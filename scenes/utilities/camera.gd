extends Camera2D

@onready var top_left: Node = $Limits/Top_left
@onready var bottom_right: Node = $Limits/Bottom_right

func _ready() -> void:
	limit_top = top_left.position.y
	limit_left = top_left.position.x
	limit_bottom = bottom_right.position.y
	limit_right = bottom_right.position.x
