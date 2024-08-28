extends State


var is_jumping := false
var is_gonna_jump := false
var jump_time : float
var cast_time : float


@onready
var jump_timer : Timer = $JumpTimer


func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		if player.velocity.y >= .0:
			player.change_state("FallState")
			return
		if is_jumping:
			player.velocity += player.get_gravity() * 0.25 * delta
		else:
			player.velocity += player.get_gravity() * delta

	if is_jumping:
		if jump_time >= .5 or not Input.is_action_pressed("jump"):
			is_jumping = false
		else:
			jump_time += delta

	if is_gonna_jump:
		if cast_time < 0.1 && not Input.is_action_pressed("jump"):
			jump_timer.stop()
			player.animation.frame = 2
			_on_jump_timer_timeout()

	if not is_gonna_jump:
		player._move()
	else:
		player.velocity.x = .0
		player.move_and_slide()


func _on_jump_timer_timeout() -> void:
	player.velocity.y = player.JUMP_VELOCITY
	is_gonna_jump = false
	is_jumping = true


func _enter_state() -> void:
	player.animation.play("jump")
	player.animation.frame = 0
	set_physics_process(true)
	jump_timer.start()
	is_gonna_jump = true
	is_jumping = false
	jump_time = .0


func _exit_state() -> void:
	$JumpTimer.stop()
	set_physics_process(false)
