class_name Player
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0


@warning_ignore("untyped_declaration")
var state


@onready
var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready
var shape : CollisionShape2D = $CollisionShape2D
@onready
var rayTop : RayCast2D = $RayCastTop
@onready
var rayBottom : RayCast2D = $RayCastBottom
@onready
var init_size : Vector2 = shape.shape.size


func _ready() -> void:
	for child in $States.get_children():
		child.player = self
	state = $States/IdleState
	state.enter_state()


func change_state(new_state : String) -> void:
	state.exit_state()
	state = get_node("States/" + new_state)
	state.enter_state()


func move() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animation.flip_h = direction < 0
	else :
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()


func change_size(value := 0.1) -> void :
	if rayTop.is_colliding() and rayBottom.is_colliding():
		BusSignal.player_died.emit()
	var new_scale := animation.scale + Vector2(value, value)
	if new_scale.x >= 5.0:
		BusSignal.player_died.emit()
	animation.scale = new_scale.maxf(0.5)
	shape.shape.size = init_size * animation.scale
	var h : float = shape.shape.size.y / 2.0
	rayTop.position.y = shape.position.y - h
	rayBottom.position.y = shape.position.y + h
	BusSignal.player_size_changed.emit(animation.scale.x)


func take_hit(monster : Node2D) -> void:
	if animation.scale.x < 2.0:
		BusSignal.player_died.emit()
	elif animation.scale.x < 3.5:
		$States/KnockBackState.velocity = 100.0 * monster.position.direction_to(position)
		change_state("KnockBackState")
	else:
		monster.die.call_deferred()
