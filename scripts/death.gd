extends Area2D


func _on_body_entered(_player : Player) -> void:
	BusSignal.player_died.emit()
