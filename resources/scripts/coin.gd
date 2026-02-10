extends Area3D

func _on_body_entered(body):
	if body is Player:
		GLOBAL.score += 10
		$Coin.queue_free() 
		$CollisionShape3D.disabled = true
		$AudioCoin.play()


func _on_audio_coin_finished():
	queue_free()
