extends Node


const CONFIG_PATH := "user://.config"
const SOUND := "sound"


var _config : ConfigFile

func _ready() -> void:
	_config = ConfigFile.new()
	_config.load(CONFIG_PATH)


func has_sound_key(key: String) -> bool:
	return _config.has_section_key(SOUND, key)


func get_sound_value(key: String) -> Variant:
	return _config.get_value(SOUND, key)


func set_sound_value(key: String, value: Variant) -> void:
	_config.set_value(SOUND, key, value)
	_config.save(CONFIG_PATH)
