extends Node


var can_go_next := false


@onready
var label : RichTextLabel = $"../CanvasLayer/GUI/Tuto/VBoxContainer/RichTextLabel"
@onready
var tuto : Control = $"../CanvasLayer/GUI/Tuto"
@onready
var player : Player = $"../Player"


func _ready() -> void:
	get_tree().paused = true
	const Music := preload("res://assets/Fantasy Vol4 Music Pack/Fantasy Vol4 Hopeful Main.wav")
	MusicHandler.play_music(Music)
	BusSignal.gem_collected.connect(on_gem_collected)
	BusSignal.player_died.connect(on_player_died)
	var key_number_link := "[img]res://assets/Keyboard/%d.png[/img]"
	var key_string_link := "[img]res://assets/Keyboard/%s.png[/img]"
	var dict := {
		"space": key_string_link % "Space",
		"echap": key_string_link % "Echap",
		"a": key_number_link % DisplayServer.keyboard_get_keycode_from_physical(KEY_A),
		"d": key_number_link % DisplayServer.keyboard_get_keycode_from_physical(KEY_D)
	}
	var text := tr("TUTO1").format(dict)
	label.append_text("[center]%s [/center]" % text)
	label.add_image(preload("res://assets/16 bit gem/green circle gem.png"))
	label.append_text(".")
	get_tree().create_timer(4.0).timeout.connect(on_timeout)


func _input(event: InputEvent) -> void:
	if not tuto:
		if event.is_action_pressed("pause"):
			BusSignal.game_paused.emit()
		return
	if not can_go_next:
		return
	if event is InputEventKey:
		get_tree().paused = false
		tuto.queue_free()
		set_process_unhandled_input(false)


func on_timeout() -> void:
	label.append_text("\n\n[center]%s[/center]" % tr("CLICK_NEXT"))
	can_go_next = true


func on_gem_collected() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/tuto2.tscn")


func on_player_died() -> void:
	get_tree().reload_current_scene.call_deferred()


func _on_timer_timeout() -> void:
	player.change_size.call_deferred()
