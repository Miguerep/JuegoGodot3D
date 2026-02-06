extends Path3D

@export var speed  : int

func _process(delta):
	$PathFollow3D.set_progress($PathFollow3D.get_progress() + speed * delta)
