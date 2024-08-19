extends Node


func _ready() -> void:
	BusSignal.player_won.connect(on_player_won)
	MusicHandler.play_music(preload("res://Fantasy Vol4 Music Pack/Fantasy Vol4 New World Main.wav"))


func on_player_won() -> void:
	get_tree().paused = true
