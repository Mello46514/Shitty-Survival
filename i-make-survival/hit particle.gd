extends GPUParticles3D

func _ready():
	emitting = true

func _process(delta):
	if not emitting:
		get_tree().queue_delete(self)
