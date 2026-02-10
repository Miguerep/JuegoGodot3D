extends Path3D

# Punto 2 del PDF
@export var speed : int

func _process(delta):

	$PathFollow3D.set_progress($PathFollow.get_progress() + speed * delta)
