extends AudioStreamPlayer


const VOLUME := "music_volume"
const MUTE := "is_music_mute"


var is_music_mute := false


func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	finished.connect(play)
	if ConfigHandler.has_sound_key(VOLUME):
		volume_db = ConfigHandler.get_sound_value(VOLUME)
	else:
		ConfigHandler.set_sound_value(VOLUME, volume_db)
	if ConfigHandler.has_sound_key(MUTE):
		is_music_mute = ConfigHandler.get_sound_value(MUTE)
	else:
		ConfigHandler.set_sound_value(MUTE, is_music_mute)


func play_music(music: AudioStream) -> void:
	stream = music
	play()
	stream_paused = is_music_mute


func set_music_volume(volume: float) -> void:
	volume_db = volume
	ConfigHandler.set_sound_value(VOLUME, volume_db)


func set_mute(value: bool) -> void:
	is_music_mute = value
	stream_paused = value
	ConfigHandler.set_sound_value(MUTE, value)
