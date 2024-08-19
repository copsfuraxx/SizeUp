extends AudioStreamPlayer


var is_mute := false


func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	finished.connect(play)


func play_music(music : AudioStream) -> void:
	stream = music
	if not is_mute:
		play()



func set_mute(value : bool) -> void:
	is_mute = value
	stream_paused = value
