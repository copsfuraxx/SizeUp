extends Node


var player : Player
var velocity : Vector2
var knock_back_timer : float


func  _ready() -> void:
	exit_state()


func _physics_process(delta: float) -> void:
	if knock_back_timer > .5:
		if not player.is_on_floor():
			player.velocity += player.get_gravity() * delta
		else:
			player.change_state("IdleState")
			return
	else:
		knock_back_timer += delta
		player.velocity = velocity
	player.move_and_slide()


func  enter_state() -> void:
	player.animation.play("knock_back")
	knock_back_timer = .0
	set_physics_process(true)


func  exit_state() -> void:
	set_physics_process(false)
