extends StaticBody3D

func _on_area_3d_body_entered(body):
	if body is Player:
		$AnimatioPlayer.play("Destroy")
		$ColisionShape3D.disabled = true
		$GPUParticles3D.emitting = true
		$Area3D.queue_free()
		$AudioHit.play()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Destroy":
		queue_free()
