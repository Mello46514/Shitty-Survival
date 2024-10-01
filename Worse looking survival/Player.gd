extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 30.5
const push_force = 80.0

var health:float = 100.0
var stamina:float = 100.0

var killfloor:bool = false
var zoompwr:int = 0

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	print(velocity.y)
	
	zoompwr = Input.get_axis("zi","zo")
	$SpringArm3D.spring_length += zoompwr
	$SpringArm3D/Camera3D.position.z = $SpringArm3D.spring_length - 0.1
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += -150 * delta
		if velocity.y < -80:
			killfloor = true
		else:
			killfloor = false
	elif killfloor == true:
		health = 0
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or is_on_wall()):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	if input_dir != Vector2.ZERO:
		$"jank look at thing".look_at(global_position + Vector3(velocity.x,0,velocity.z))
		$"jank look at thing".global_rotation += rotation
	$model.global_rotation.y = $"jank look at thing".rotation.y
	
	
	_push_away_rigid_bodies()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x
		$SpringArm3D.rotation_degrees.x -= event.relative.y
		$SpringArm3D.rotation_degrees.x = clamp($SpringArm3D.rotation_degrees.x,-90,30)



### i stole this lol
## credits to Majikayo Games :)
# https://www.youtube.com/watch?v=Uh9PSOORMmA
# https://gist.github.com/majikayogames/cf013c3091e9a313e322889332eca109
# CC0/public domain/use for whatever you want no need to credit
# Call this function directly before move_and_slide() on your CharacterBody3D script
func _push_away_rigid_bodies():
	for i in get_slide_collision_count():
		var c := get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			var push_dir = -c.get_normal()
			# How much velocity the object needs to increase to match player velocity in the push direction
			var velocity_diff_in_push_dir = self.velocity.dot(push_dir) - c.get_collider().linear_velocity.dot(push_dir)
			# Only count velocity towards push dir, away from character
			velocity_diff_in_push_dir = max(0., velocity_diff_in_push_dir)
			# Objects with more mass than us should be harder to push. But doesn't really make sense to push faster than we are going
			const MY_APPROX_MASS_KG = 100.0
			var mass_ratio = min(1., MY_APPROX_MASS_KG / c.get_collider().mass)
			# Optional add: Don't push object at all if it's 4x heavier or more
			if mass_ratio < 0.25:
				continue
			# Don't push object from above/below
			push_dir.y = 0
			# 5.0 is a magic number, adjust to your needs
			var push_force = mass_ratio * 5.0
			c.get_collider().apply_impulse(push_dir * velocity_diff_in_push_dir * push_force, c.get_position() - c.get_collider().global_position)
