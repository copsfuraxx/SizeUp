extends Area2D


func _on_body_entered(_player: Player) -> void:
	BusSignal.gem_collected.emit()
	queue_free()
