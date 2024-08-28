extends CenterContainer


signal return_clicked


@onready
var music_slider: Slider =\
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/MusicSlider
@onready
var music_checkbox: CheckButton =\
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/MusicCheckBox


func  _ready() -> void:
	music_slider.value = db_to_linear(MusicHandler.volume_db) * 100
	music_checkbox.button_pressed = MusicHandler.is_music_mute


func _on_music_slider_value_changed(value: float) -> void:
	if value != music_slider.value:
		return
	MusicHandler.set_music_volume(music_slider.value / 100)


func _on_music_check_box_toggled(toggled_on: bool) -> void:
	MusicHandler.set_mute(toggled_on)


func _on_return_pressed() -> void:
	return_clicked.emit()
