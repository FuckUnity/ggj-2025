extends Sprite2D

var help : Sprite2D
var game : Node2D

var og_scale
var hover_scale

func _ready() -> void:
	help = $"../../Help"
	game = $".."
	og_scale = scale
	hover_scale = scale * 1.2


func _on_start_mouse_entered() -> void:
	scale = hover_scale

func _on_start_mouse_exited() -> void:
	scale = og_scale

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		if get_rect().has_point(to_local(event.position)):
			help.visible = true
			game.visible = false
