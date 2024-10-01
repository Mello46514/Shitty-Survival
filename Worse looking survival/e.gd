extends Node3D

func _ready():
	for i in range(randi_range(16,70)):
		var a = preload("res://nat_pillar.tscn").instantiate()
		a.position.x = randi_range(-500,500)
		a.position.z = randi_range(-500,500)
		$ahh.add_child(a)
	for i in range(randi_range(70,270)):
		var a = preload("res://nat_pillar.tscn").instantiate()
		a.position.y = -2500
		a.position.x = randi_range(-500,500)
		a.position.z = randi_range(-500,500)
		$ahh.add_child(a)

func _process(delta):
	if abs(roundi($VoxelGI/DirectionalLight3D.rotation_degrees.x)) >= 360:
		$VoxelGI/DirectionalLight3D.rotation_degrees.x = 0
	$VoxelGI/DirectionalLight3D.rotation_degrees.x -= .01
	if $VoxelGI/DirectionalLight3D.rotation_degrees.x > -180 and $VoxelGI/DirectionalLight3D.rotation_degrees.x < 0:
		print("day")
		$VoxelGI/DirectionalLight3D.light_energy = .5
		$VoxelGI/DirectionalLight3D/DirectionalLight3D2.light_energy = .5
		$VoxelGI/DirectionalLight3D/DirectionalLight3D3.light_energy = .5
	else:
		print("night")
		$VoxelGI/DirectionalLight3D.light_energy = 0
		$VoxelGI/DirectionalLight3D/DirectionalLight3D2.light_energy = 0
		$VoxelGI/DirectionalLight3D/DirectionalLight3D3.light_energy = 0
	print($VoxelGI/DirectionalLight3D.rotation_degrees.x)
