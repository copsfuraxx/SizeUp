extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	var player := body as Player
	player.change_size.call_deferred(-1)
	queue_free()
