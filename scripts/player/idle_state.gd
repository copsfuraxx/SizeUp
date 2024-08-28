extends State


func _physics_process(_delta: float) -> void:
	if not player.is_on_floor():
		player.change_state("FallState")
		return
	if Input.is_action_pressed("jump"):
		player.change_state("JumpState")
		return
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		player.change_state("RunState")
		return
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.move_and_slide()


func _enter_state() -> void:
	player.animation.play("idle")
	set_physics_process(true)


func _exit_state() -> void:
	set_physics_process(false)
