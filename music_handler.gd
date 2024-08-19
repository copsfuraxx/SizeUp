extends AudioStreamPlayer


var is_mute := false


func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS


func play_music(music : AudioStream) -> void:
	stream = music
	if not is_mute:
		play()
