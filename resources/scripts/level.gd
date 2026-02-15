extends Node3D

func _ready():
	# Reiniciar puntuación
	GLOBAL.score = 0
	# Pausar el juego hasta que termine la intro (FadeIn)
	get_tree().paused = true
