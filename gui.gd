extends Control


@onready
var size_bar : TextureProgressBar = $TextureProgressBar
@onready
var win_screen : PanelContainer = $WinScreen


func _ready() -> void:
	BusSignal.player_size_changed.connect(on_player_size_changed)
	BusSignal.player_won.connect(on_player_won)


func on_player_size_changed(new_size: float) -> void:
	size_bar.value = new_size


func on_player_won() -> void:
	win_screen.visible = true
