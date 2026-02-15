extends CharacterBody3D
class_name Player

# --- VARIABLES DEL PDF ---
var can_move : bool = false
var axis : Vector2
var rot : Vector3
var angle : float

const SPEED = 12
const GRAVITY = 2
const JUMP = 30

# Referencia a la GUI (necesaria para morir, etc.)
@onready var gui : CanvasLayer = get_tree().get_first_node_in_group("GUI")

# --- BUCLE PRINCIPAL ---
func _process(delta):
	# Aplicar gravedad siempre (para que caiga si está en el aire)
	if not is_on_floor():
		velocity.y -= GRAVITY
		
	match can_move:
		true:
			motion_ctrl()
			move_and_slide()
		false:
			# Si no puede moverse (intro o muerte), solo cae
			move_and_slide()

# --- CONTROL DE SALTO (Según PDF) ---
func _input(event):
	if can_move and is_on_floor() and event.is_action_pressed("ui_accept"):
		velocity.y = JUMP
		$AudioJump.play()

# --- DETECCIÓN DE TECLAS (Según PDF + Corrección) ---
func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_up")) - int(Input.is_action_pressed("ui_down"))
	return axis.normalized()

# --- LÓGICA DE MOVIMIENTO Y SPRINT ---
func motion_ctrl() -> void:
	# 1. Detectar si pulsamos SHIFT para correr
	var current_speed = SPEED
	if Input.is_key_pressed(KEY_SHIFT):
		current_speed = SPEED * 1.5  # Doble de velocidad
	
	'''MOVIMIENTO'''
	# Usamos current_speed en vez de SPEED constante
	velocity.x = get_axis().x * current_speed
	# velocity.y se gestiona en _process con la gravedad
	velocity.z = get_axis().y * -current_speed # Negativo según tu PDF
	
	'''ROTACIÓN'''
	if get_axis().length() > 0:
		angle = atan2(get_axis().x, -get_axis().y)
		rotation.y = angle
	
	'''ANIMACIONES'''
	if is_on_floor():
		if get_axis().length() > 0:
			$AnimationPlayer.play("Run")
			
			# Truco visual: Si corre con Shift, la animación va más rápido
			if current_speed > SPEED:
				$AnimationPlayer.speed_scale = 1.5
			else:
				$AnimationPlayer.speed_scale = 1.0
				
			$GPUParticles3D.emitting = true
		else:
			$AnimationPlayer.play("Idle")
			$AnimationPlayer.speed_scale = 1.0
			$GPUParticles3D.emitting = false
	else:
		# En el aire
		if velocity.y > 0:
			$AnimationPlayer.play("Jump")
		$GPUParticles3D.emitting = false

# --- FINALIZACIÓN DE ANIMACIONES ---
func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Wave":
			can_move = true # Desbloquea el movimiento al terminar la intro

# --- MUERTE DEL JUGADOR ---
func die():
	if not can_move: return
	can_move = false
	
	if has_node("AudioHit"):
		$AudioHit.play()
	
	if gui:
		gui.get_node("FadeScreen/AnimationPlayer").play("FadeOut")
	else:
		get_tree().reload_current_scene()
