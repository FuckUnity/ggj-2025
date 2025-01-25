class_name DraggableBody extends CharacterBody2D

var is_grabbing = false
var grabbed_offset = Vector2()

func _input(event: InputEvent) -> void:
	if(event is InputEventMouseButton and !event.is_pressed()):
		is_grabbing = false
		grabbed_offset = null
		
	if event is InputEventMouseMotion and is_grabbing:
		position = get_global_mouse_position() + grabbed_offset

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		is_grabbing = true
		grabbed_offset = position - get_global_mouse_position()
