extends CharacterBody2D

@export var Speed: float = 100
@export var starting_direction: Vector2 = Vector2(0, 1)
@onready var animation_tree: Node = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

func _ready() -> void:
	update_animation_parameters(starting_direction)

func _physics_process(_delta) -> void:
	var input_direction: Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	look_at_mouse()

	update_animation_parameters(input_direction)

	velocity = input_direction * Speed

	move_and_slide()

	pick_new_state()

func update_animation_parameters(move_input : Vector2) -> void:
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Walk/blend_position", move_input)

func pick_new_state() -> void:
	if velocity != Vector2.ZERO:
		playback.travel("Walk")
	else:    
		playback.travel("Idle")    

func look_at_mouse() -> void:
	var mouse_direction: Vector2 = position.direction_to(get_global_mouse_position())
	animation_tree.set("parameters/Idle/blend_position", mouse_direction)
	animation_tree.set("parameters/Walk/blend_position", mouse_direction)

