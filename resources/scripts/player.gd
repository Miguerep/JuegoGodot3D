extends CharacterBody3D
class_name Player


var can_move : bool = false
var axis : Vector2
var rot : Vector3
var angle : float

const SPEED = 12
const GRAVITY = 2
const JUMP : int = 30

func _process(delta):
	
	
	match can_move:
		true:
			motion_ctrl(delta)

func _input(event):
	if is_on_floor() and event.is_action_pressed("ui_accept"):
		velocity.y = JUMP
		$AudioJump.play()

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func motion_ctrl(delta) -> void:
	'''MOVIMIENTO'''
	velocity.x = get_axis().x * SPEED
	velocity.y -= GRAVITY
	velocity.z = get_axis().y * -SPEED # Quitamos el negativo si los controles se sienten invertidos
	
	'''ROTACIÓN'''
	if get_axis().x == 0 or not get_axis().y == 0:
		angle = atan2(get_axis().x, get_axis().y)
		rot = get_rotation() # Obtenemos rotación actual
		rot.y = angle  # Asignamos nuevo ángulo
		set_rotation(rot)# Aplicamos rotación (Punto 19 simplificado)
	move_and_slide()

	'''ANIMACIONES'''
	match is_on_floor():
		true:
			if get_axis().x == 0 or not get_axis().y == 0:
				$AnimationPlayer.play("Run")
				$GPUParticles3D.emitting = true
			else:
				$AnimationPlayer.play("Idle")
				$GPUParticles3D.emitting = false
		false:
			if velocity.y > 0:
				$AnimationPlayer.play("Jump")
				$GPUParticles3D.emitting = false

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Wave":
			can_move = true
