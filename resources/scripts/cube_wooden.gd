extends StaticBody3D

func _on_area_3d_body_entered(body):
	if body is Player:
		$AnimationPlayer.play("Destroy")
		$CollisionShape3D.set_deferred("disabled", true)
		
		$GPUParticles3D.emitting = true
		$Area3D.queue_free()
		$AudioHit.play()

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Destroy":
			queue_free()
