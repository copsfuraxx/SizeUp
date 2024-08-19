extends Area2D


enum Type {
	YELLOW,
	BLUE
}


@export
var type := Type.BLUE
@export
var value := 1.0


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	var player := body as Player
	player.change_size.call_deferred(-value if type == Type.BLUE else value)
	queue_free()
