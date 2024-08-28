extends Area2D


enum Type {
	YELLOW,
	BLUE
}


@export
var type := Type.BLUE
@export
var value := 1.0


func _on_body_entered(player: Player) -> void:
	player.change_size.call_deferred(-value if type == Type.BLUE else value)
	queue_free()
