extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var resume: Button = find_child("Resume")
@onready var quit: Button = find_child("Quit")

func _ready() -> void:
	resume.pressed.connect(unpause)
	quit.pressed.connect(get_tree().quit)

func unpause() -> void:
	animation_player.play("Unpause")
	get_tree().paused = false

func pause() -> void:
	animation_player.play("Pause")
	get_tree().paused = true

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		pause()
