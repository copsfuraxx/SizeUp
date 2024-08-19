extends Control


@onready
var menu: Control = $Menu
@onready
var parameters: Control = $Parameters
@onready
var music_slider: Slider = $Parameters/VBoxContainer/HBoxContainer/MusicSlider

func  _ready() -> void:
	MusicHandler.play_music(preload("res://Fantasy Vol4 Music Pack/Fantasy Vol4 Seasonal Main.wav"))
	music_slider.value = db_to_linear(MusicHandler.volume_db) * 100


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://test.tscn")


func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://tuto1.tscn")


func _on_parameters_button_pressed() -> void:
	print("test")
	menu.visible = false
	parameters.visible = true


func _on_music_slider_value_changed(value: float) -> void:
	if value  != music_slider.value:
		return
	MusicHandler.volume_db = linear_to_db(music_slider.value / 100)


func _on_music_check_box_toggled(toggled_on: bool) -> void:
	MusicHandler.stream_paused = toggled_on
