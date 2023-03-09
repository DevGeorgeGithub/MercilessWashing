extends Area2D

@export_file var target_scene

func _on_body_entered(body) -> void:
	get_tree().change_scene_to_file(target_scene)
