extends Node3D

func _ready() -> void:
	# Punto 9 del PDF
	GLOBAL.score = 0
	get_tree().paused = true # Pausa el juego al iniciar
