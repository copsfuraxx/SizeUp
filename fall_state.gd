extends Node


var player : Player


func _ready() -> void:
	exit_state()


func  _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * 1.5 * delta
	else:
		player.change_state("IdleState")
		return
	player.move()


func  enter_state() -> void:
	player.animation.animation = "fall"
	set_physics_process(true)


func  exit_state() -> void:
	set_physics_process(false)
