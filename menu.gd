extends Control


@onready
var menu: Control = $Menu
@onready
var parameters: Control = $Parameters
@onready
var credits: Control = $Credits
@onready
var music_slider: Slider =\
	$Parameters/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/MusicSlider
@onready
var music_checkbox: CheckButton =\
	$Parameters/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/MusicCheckBox

func  _ready() -> void:
	MusicHandler.play_music(preload("res://Fantasy Vol4 Music Pack/Fantasy Vol4 Seasonal Main.wav"))
	music_slider.value = db_to_linear(MusicHandler.volume_db) * 100
	music_checkbox.button_pressed = MusicHandler.is_mute
	$Credits/PanelContainer/MarginContainer/VBoxContainer/RichTextLabel.custom_minimum_size.x =\
		get_viewport_rect().size.x / 4.0 * 3.0


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://test.tscn")


func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://tuto1.tscn")


func _on_parameters_button_pressed() -> void:
	menu.visible = false
	parameters.visible = true


func _on_credits_button_pressed() -> void:
	menu.visible = false
	credits.visible = true


func _on_music_slider_value_changed(value: float) -> void:
	if value  != music_slider.value:
		return
	MusicHandler.volume_db = linear_to_db(music_slider.value / 100)


func _on_music_check_box_toggled(toggled_on: bool) -> void:
	MusicHandler.set_mute(toggled_on)


func _on_return_pressed() -> void:
	parameters.visible = false
	credits.visible = false
	menu.visible = true


func _on_rich_text_label_meta_clicked(meta: Variant) -> void:
	OS.shell_open(meta)
	
