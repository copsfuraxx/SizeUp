extends Control


var is_paused := false
var was_paused : bool


@onready
var size_bar : TextureProgressBar = $TextureProgressBar
@onready
var win_screen : Control = $WinScreen
@onready
var pause_screen : Control = $PauseScreen
@onready
var parameters : Control = $PauseScreen/Parameters
@onready
var menu : Control = $PauseScreen/Menu


func _ready() -> void:
	BusSignal.player_size_changed.connect(on_player_size_changed)
	BusSignal.player_won.connect(on_player_won)
	BusSignal.game_paused.connect(on_game_paused)


func on_player_size_changed(new_size: float) -> void:
	size_bar.value = new_size


func on_player_won() -> void:
	win_screen.visible = true


func on_game_paused() -> void:
	if not is_paused:
		was_paused = get_tree().paused
		is_paused = true
		get_tree().paused = true
	else:
		_on_return_pressed()
		is_paused = false
		get_tree().paused = was_paused
	pause_screen.visible = is_paused


func _on_play_pressed() -> void:
	on_game_paused()


func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_parameters_button_pressed() -> void:
	menu.visible = false
	parameters.visible = true


func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_return_pressed() -> void:
	parameters.visible = false
	menu.visible = true
