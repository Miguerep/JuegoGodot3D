extends Path3D

@export var speed : int

func _process(delta):
	# Mover el PathFollow3D hijo
	$PathFollow3D.progress += speed * delta
