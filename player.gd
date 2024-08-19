class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0


var timer_last_on_floor := .0
var timer_start_jump := .0
var is_jumping := false
var is_gonna_jump := false
var is_falling := false


@onready
var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready
var jump_timer : Timer = $JumpTimer
@onready
var shape : CollisionShape2D = $CollisionShape2D
@onready
var rayTop : RayCast2D = $RayCastTop
@onready
var rayBottom : RayCast2D = $RayCastBottom
@onready
var init_size = shape.shape.size


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not is_jumping:
		timer_last_on_floor += delta
		if velocity.y > 0:
			velocity += get_gravity() * 1.5 * delta
		velocity += get_gravity() * delta
	elif not is_jumping:
		is_falling = false
		timer_last_on_floor = .0

	if is_gonna_jump:
		return
	if is_jumping:
		timer_start_jump += delta
		if Input.is_action_pressed("jump") and timer_start_jump < .5 and not is_on_ceiling():
			velocity.y = JUMP_VELOCITY
		else:
			is_jumping = false
			is_falling = true

	# Handle jump.
	if Input.is_action_pressed("jump") and can_jump():
		jump_timer.start()
		is_gonna_jump = true
		animation.frame = 0
		animation.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animation.flip_h = direction < 0
		if is_not_mid_air():
			animation.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_not_mid_air():
			animation.play("idle")

	move_and_slide()


func _on_jump_timer_timeout() -> void:
	velocity.y = JUMP_VELOCITY
	is_gonna_jump = false
	is_jumping = true
	timer_start_jump = .0
	timer_last_on_floor = 1.0


func _on_grow_timer_timeout() -> void:
	animation.scale += Vector2(0.1, 0.1)
	shape.shape.size = init_size * animation.scale


func is_not_mid_air() -> bool:
	return not is_gonna_jump and not is_jumping and not is_falling and is_on_floor()


func can_jump() -> bool:
	return is_not_mid_air() or timer_last_on_floor < .5


func change_size(value := 0.1) -> void :
	if rayTop.is_colliding() and rayBottom.is_colliding():
		get_tree().reload_current_scene()
		BusSignal.player_died.emit()
	var new_scale = animation.scale + Vector2(value, value)
	animation.scale = new_scale.maxf(0.5)
	shape.shape.size = init_size * animation.scale
	var h = shape.shape.size.y / 2
	rayTop.position.y = shape.position.y - h
	rayBottom.position.y = shape.position.y + h
	BusSignal.player_size_changed.emit(animation.scale.x)
