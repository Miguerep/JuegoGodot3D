extends Area3D

func _on_body_entered(body):
	if body is Player:
		# Punto 4a: Sumar puntos
		GLOBAL.score += 10
		
		# Punto 4b: Borrar visualmente la moneda
		$Coin.queue_free() 
		
		$CollisionShape3D.set_deferred("disabled", true)
		
		# Punto 4d: Sonido
		$AudioCoin.play()

func _on_audio_coin_finished():
	queue_free()
