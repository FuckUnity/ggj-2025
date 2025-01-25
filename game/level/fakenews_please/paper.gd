class_name Paper extends DraggableBody

enum PaperState {NONE, CHECKED, FAKE}
	
var paper_state = PaperState.NONE

func get_global_rect():
	var size = $"Sprite2D".texture.get_size() * $"Sprite2D".global_scale;
	return Rect2(global_position - size / 2, size)
