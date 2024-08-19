extends Area2D


const SPEED = 50.0


@export
var start : Marker2D
@export
var end : Marker2D


var dest : Vector2


func _ready() -> void:
	dest = end.position
	var dir := position.direction_to(dest)
	$AnimatedSprite2D.flip_h = dir.x > .0


func _physics_process(delta: float) -> void:
	var old_position := position
	var dir := position.direction_to(dest)
	position = position + dir * SPEED * delta
	if has_reach_dest(old_position):
		dest = start.position if dest == end.position else end.position
		$AnimatedSprite2D.flip_h = not dir.x > .0


func has_reach_dest(old_position : Vector2) -> bool:
	return (old_position < dest and position >= dest) or (old_position > dest && position <= dest)


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	var player : Player = body
	player.take_hit(self)


func die() -> void:
	queue_free()
