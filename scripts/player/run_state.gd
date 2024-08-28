extends State


func _physics_process(_delta: float) -> void:
	if not player.is_on_floor():
		player.change_state("FallState")
		return
	if Input.is_action_pressed("jump"):
		player.change_state("JumpState")
		return
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * player.SPEED
		player.animation.flip_h = direction < 0
		player.move_and_slide()
	else:
		player.change_state("IdleState")


func _enter_state() -> void:
	player.animation.play("run")
	set_physics_process(true)


func _exit_state() -> void:
	set_physics_process(false)
