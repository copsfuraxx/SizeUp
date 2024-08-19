extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	BusSignal.gem_collected.emit()
	queue_free()
