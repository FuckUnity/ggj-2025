extends Sprite2D

var help : Sprite2D
var game : Node2D


func _ready() -> void:
	help = $".." 
	game = $"../../game"
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		if get_rect().has_point(to_local(event.position)):
			help.visible = false
			game.visible = true
