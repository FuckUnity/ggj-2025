extends Sprite2D

var f : Callable

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		if get_rect().has_point(to_local(event.position)):
			f.call()
