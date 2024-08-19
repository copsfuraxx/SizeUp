extends Node


var player : Player
var is_jumping := false
var is_gonna_jump := false
var jump_time : float


@onready
var jump_timer : Timer = $JumpTimer


func _ready() -> void:
	exit_state()


func  _physics_process(delta: float) -> void:
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

	if not is_gonna_jump:
		player.move()
	else:
		player.velocity.x = .0
		player.move_and_slide()


func _on_jump_timer_timeout() -> void:
	player.velocity.y = player.JUMP_VELOCITY
	is_gonna_jump = false
	is_jumping = true


func  enter_state() -> void:
	player.animation.play("jump")
	player.animation.frame = 0
	set_physics_process(true)
	jump_timer.start()
	is_gonna_jump = true
	is_jumping = false
	jump_time = .0


func  exit_state() -> void:
	$JumpTimer.stop()
	set_physics_process(false)
