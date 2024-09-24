extends Node3D

var health = 10
var pos = Vector3()

func _process(delta):
	pos = global_position
	if $Area3D.has_overlapping_bodies():
		if Input.is_action_just_pressed("ui_accept"):
			health -= 1
			var e = preload("res://hit particle.tscn").instantiate()
			e.global_position = global_position
			add_sibling(e)
	if health == 0:
		var a = preload("res://Log.tscn").instantiate()
		a.global_position = pos + Vector3(0,2,0)
		a.rotation_degrees = Vector3(randi_range(0,360),randi_range(0,360),randi_range(0,360))
		add_sibling(a)
		get_tree().queue_delete(self)
