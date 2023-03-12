extends Node
class_name Save_game

@export var map_name: String
@export var global_position: Vector2

var save_game_path: String
var save_dict: Dictionary
var button: Node
var button_text: String

func save() -> Dictionary:
	save_dict = {
		"global_position" : global_position,
		"map" : map_name,
		"button_text": button_text,
	}
	return save_dict

func save_data() -> void:
	var save_game = FileAccess.open(save_game_path, FileAccess.WRITE)
	
	var node_data = save()

	save_game.store_var(node_data)

func load_data() -> void:
	if not FileAccess.file_exists(save_game_path):
		return

	var save_game = FileAccess.open(save_game_path, FileAccess.READ)
	
	save_dict = save_game.get_var()
	

