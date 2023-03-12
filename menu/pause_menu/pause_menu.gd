extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var resume_button: Button = find_child("Resume")
@onready var save_button: Button = find_child("Save")
@onready var load_button: Button = find_child("Load")
@onready var restart_button: Button = find_child("Restart")
@onready var quit_button: Button = find_child("Quit")

@onready var is_pause_menu: bool = true

var save_game = Save_game.new()

func _ready() -> void:
	resume_button.pressed.connect(unpause)
	save_button.pressed.connect(save_menu_show)
	load_button.pressed.connect(load_menu_show)
	restart_button.pressed.connect(restart_game)
	quit_button.pressed.connect(get_tree().quit)
	
func unpause() -> void:
	animation_player.play("Unpause")
	get_tree().paused = false

func pause() -> void:
	animation_player.play("Pause")
	get_tree().paused = true

func load_menu_show() -> void:
	is_pause_menu = false
	animation_player.play("Load_menu_show")
	$Pause_menu/Panel/CenterContainer/Load_menu.buttons_text_update()

func save_menu_show() -> void:
	is_pause_menu = false
	animation_player.play("Save_menu_show")
	$Pause_menu/Panel/CenterContainer/Save_menu.buttons_text_update()

func restart_game() -> void:
	get_tree().reload_current_scene()
	global.global_position = Vector2.ZERO
	unpause()

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused and is_pause_menu:
			unpause()
		else:
			pause()
			is_pause_menu = true
