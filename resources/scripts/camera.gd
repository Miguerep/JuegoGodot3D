extends Camera3D
@export var player : CharacterBody3D

func _ready():
	global_position.y = 9

func _process(_delta):
	if player:
		global_position.x = player.position.x
		global_position.z = player.position.z + 10
