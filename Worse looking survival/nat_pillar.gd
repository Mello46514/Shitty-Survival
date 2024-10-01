extends CSGCombiner3D

func _ready():
	$CSGBox3D.size = Vector3(randi_range(1,250),randi_range(1,1000),randi_range(1,250))
	global_position.y = $CSGBox3D.size.y/2
	for i in range(randi_range(5,20)):
		var ahh = preload("res://BoxForPillar.tscn").instantiate()
		ahh.position = Vector3(randi_range(-1,1) * ($CSGBox3D.size.x/2),randi_range(0,$CSGBox3D.size.y/2),randi_range(-1,1) * ($CSGBox3D.size.z/2))
		ahh.rotation_degrees = Vector3(randi_range(0,360),randi_range(0,360),randi_range(0,360))
		add_child(ahh)
