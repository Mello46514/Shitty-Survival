extends CSGBox3D

func _ready():
	size = Vector3(randi_range(1,100),randi_range(1,100),randi_range(1,100))
	
	if randi_range(0,2) == 1:
		operation = CSGShape3D.OPERATION_UNION
	else:
		operation = CSGShape3D.OPERATION_SUBTRACTION
