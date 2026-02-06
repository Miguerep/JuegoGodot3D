extends CharacterBody3D
class_name Player

var can_move : bool = false
const SPEED = 12
const GRAVITY = 60 # Aumentado porque se multiplica por delta
const JUMP = 20

func _physics_process(delta):
	# Aplicar gravedad siempre que no esté en el suelo
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		# Pequeña fuerza hacia abajo para mantener contacto con el suelo
		if velocity.y < 0:
			velocity.y = -0.1

	if can_move:
		motion_ctrl()
	else:
		# Si no puede moverse, desacelerar gradualmente o frenar de golpe
		velocity.x = 0
		velocity.z = 0
		move_and_slide()

func _input(event):
	# Solo saltar si puede moverse y está en el suelo
	if can_move and is_on_floor() and event.is_action_pressed("ui_accept"):
		velocity.y = JUMP
		$AudioJump.play()

func get_axis() -> Vector2:
	var input_axis = Vector2.ZERO
	input_axis.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_axis.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return input_axis.normalized()

func motion_ctrl() -> void:
	var current_axis = get_axis()
	
	# Movimiento
	velocity.x = current_axis.x * SPEED
	velocity.z = current_axis.y * -SPEED

	# Rotación
	if current_axis.length() > 0:
		var target_angle = atan2(current_axis.x, -current_axis.y)
		rotation.y = target_angle # Simplificado: asignación directa
		
	move_and_slide()

	# --- GESTIÓN DE ANIMACIONES ---
	if is_on_floor():
		if current_axis.length() > 0:
			$AnimationPlayer.play("Run")
			$GPUParticles3D.emitting = true
		else:
			$AnimationPlayer.play("Idle")
			$GPUParticles3D.emitting = false
	else:
		if velocity.y > 0:
			$AnimationPlayer.play("Jump")
			$GPUParticles3D.emitting = false
		else:
			# Opcional: Podrías añadir una animación de "Fall" (Caída)
			pass

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Wave":
		can_move = true
