extends Camera3D
@export var player : CharacterBody3D

func _ready():
	position.y = 9

func _process(_delta):
		position.x = player.position.x
		position.z = player.position.z + 10
