extends GridContainer

@onready var buttons: Array[Node] = [
	$Load_button_1,
	$Load_button_2,
	$Load_button_3,
	$Load_button_4
]

var save_game = Save_game.new()
var save_path: String

func _ready() -> void:
	for button in buttons:
		button.pressed.connect(load_data)

func buttons_text_update() -> void:
	for button in buttons:
		save_game.save_game_path = "user://" + button.get_name().replace("Load", "Save").replace("button", "game") + ".save"
		save_game.load_data()
		if FileAccess.file_exists(save_game.save_game_path):
			button.text = save_game.save_dict.button_text

func load_data() -> void:
	button_pressed()
	save_game.save_game_path = save_path
	save_game.load_data()
	get_tree().change_scene_to_file(save_game.save_dict.map)
	global.global_position = Vector2(save_game.save_dict.global_position)
	owner.unpause()
	
func button_pressed() -> void:
	for button in buttons:
		if button.is_pressed():
			save_path = "user://" + button.get_name().replace("Load", "Save").replace("button", "game") + ".save"
