extends CanvasLayer

func _process(delta):
	$Container/Score.text = "Score: " + str(GLOBAL.score)

func _on_animation_player_started(anim_name):
	match anim_name: 
		"FadeOut": 
			get_tree().paused = true
			$AudioGameOver.play()
func _on_animation_player_finished(anim_name):
	match anim_name:
		"FadeIn":
			get_tree().paused = false

func _on_audio_game_over_finished():
	get_tree().reload_current_scene()
