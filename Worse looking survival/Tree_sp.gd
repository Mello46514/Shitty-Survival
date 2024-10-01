extends SpringArm3D

func _ready():
	var a = preload("res://tree.tscn").instantiate()
	a.global_position = $Node3D.global_position
	get_parent().add_sibling(a)
