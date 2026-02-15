extends Camera3D

@export var player : CharacterBody3D

func _ready():
	position.y = 9

func _process(delta):
	# Seguir al jugador en X
	position.x = player.position.x
	# Seguir al jugador en Z con offset de 10
	position.z = player.position.z + 10
