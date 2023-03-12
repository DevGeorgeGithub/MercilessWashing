extends GridContainer

@onready var buttons: Array[Node] = [
	$Save_button_1,
	$Save_button_2,
	$Save_button_3,
	$Save_button_4
]

var save_game = Save_game.new()
var save_path: String

func _ready() -> void:
	for button in buttons:
		button.pressed.connect(save_data)
		
func buttons_text_update() -> void:
	for button in buttons:
		save_game.save_game_path = "user://" + button.get_name().replace("button", "game") + ".save"
		save_game.load_data()
		if FileAccess.file_exists(save_game.save_game_path):
			button.text = save_game.save_dict.button_text

func save_data() -> void:
	button_pressed()
	save_game.save_game_path = save_path
	save_game.map_name = get_tree().current_scene.scene_file_path
	save_game.global_position = get_node("../../../../../Player").global_position
	save_game.save_data()

func button_pressed() -> void:
	for button in buttons:
		if button.is_pressed():
			save_path = "user://" + button.get_name().replace("button", "game") + ".save"
			button.text = get_tree().get_current_scene().get_name() + "\n" + \
			Time.get_date_string_from_system() + " " + Time.get_time_string_from_system()

			save_game.button_text = button.text

