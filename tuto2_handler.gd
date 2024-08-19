extends Node


var can_go_next := false
var is_end_text := false


@onready
var label : RichTextLabel = $"../CanvasLayer/GUI/Tuto/VBoxContainer/RichTextLabel"
@onready
var tuto : Control = $"../CanvasLayer/GUI/Tuto"
@onready
var player : Player = $"../Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	BusSignal.gem_collected.connect(on_gem_collected)
	BusSignal.player_died.connect(on_player_died)
	label.append_text("[center]%s [/center]" % tr("TUTO2"))
	label.add_image(preload("res://All Potions/blue_potion1.tres"))
	label.append_text(".")
	get_tree().create_timer(3.0).timeout.connect(on_timeout)


func _input(event: InputEvent) -> void:
	if not tuto.visible:
		if event.is_action_pressed("pause"):
			BusSignal.game_paused.emit()
		return
	if not can_go_next:
		return
	if event is InputEventKey:
		if not is_end_text:
			get_tree().paused = false
			tuto.visible = false
			label.clear()
			label.append_text("[center]%s[/center]" % tr("TUTO_END"))
			is_end_text = true
			set_process_unhandled_input(false)
		else:
			get_tree().paused = false
			get_tree().change_scene_to_file("res://menu.tscn")


func on_timeout() -> void:
	label.append_text("\n\n[center]%s[/center]" % tr("CLICK_NEXT"))
	can_go_next = true


func on_gem_collected() -> void:
	get_tree().paused = true
	tuto.visible = true
	can_go_next = false
	set_process_unhandled_input(true)
	get_tree().create_timer(3.0).timeout.connect(on_timeout)


func on_player_died() -> void:
	get_tree().reload_current_scene.call_deferred()


func _on_timer_timeout() -> void:
	player.change_size.call_deferred()
