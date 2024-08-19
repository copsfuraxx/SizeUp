extends Node


@onready
var player : Player = $"../Player"


func _ready() -> void:
	BusSignal.gem_collected.connect(on_gem_collected)
	BusSignal.player_died.connect(on_player_died)
	MusicHandler.play_music(preload("res://Fantasy Vol4 Music Pack/Fantasy Vol4 New World Main.wav"))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		BusSignal.game_paused.emit()


func on_gem_collected() -> void:
	get_tree().paused = true
	$Timer.stop()
	BusSignal.player_won.emit()


func on_player_died() -> void:
	get_tree().reload_current_scene.call_deferred()


func _on_timer_timeout() -> void:
	player.change_size.call_deferred()
