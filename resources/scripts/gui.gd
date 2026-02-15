extends CanvasLayer

func _process(delta):
	# Actualizar texto de puntuación
	$Container/Score.text = "Score: " + str(GLOBAL.score)

func _on_animation_player_animation_started(anim_name):
	match anim_name:
		"FadeOut":
			get_tree().paused = true
			$AudioGameOver.play()

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"FadeIn":
			# IMPORTANTE: Aquí se quita la pausa inicial
			get_tree().paused = false

func _on_audio_game_over_finished():
	get_tree().reload_current_scene()
