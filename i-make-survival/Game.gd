extends Node3D



func _ready():
	for i in range(0,randi_range(2000,4500)):
		var e = preload("res://Tree.tscn").instantiate()
		e.global_position = Vector3(randf_range(-2500,2500),.5,randf_range(-2500,2500))
		e.scale = Vector3(5,5,5)
		add_child(e)
