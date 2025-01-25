class_name Paper extends DraggableBody

const FakenewsPlease = preload("res://level/fakenews_please/fakenews_please.gd")

enum PaperState {NONE, CHECKED, FAKE}
	
var paper_state = PaperState.NONE
var customer: Customer

func init(customer: Customer):
	self.customer = customer
	paper_state = customer.is_fake
	$"Sprite2D".texture = customer.paper_texture

func get_global_rect():
	return _get_global_rect($"Sprite2D")

func _on_drag_end():
	var drop_off_point = $"../../CustomerClipping" as Sprite2D
	var drop_off_rect = _get_global_rect(drop_off_point)
	var paper_rect = _get_global_rect($"Sprite2D")
	
	var intersect = drop_off_rect.intersection(paper_rect);
	var percentage_drop = (intersect.size.x * intersect.size.y) / (paper_rect.size.x * paper_rect.size.y)
	
	if percentage_drop > 0.2:
		($"../../.." as FakenewsPlease).hand_back(self)
	
func _get_global_rect(sprite: Sprite2D):
	var size = sprite.texture.get_size() * sprite.global_scale;
	return Rect2(sprite.global_position - (size / 2 if sprite.centered else Vector2.ZERO), size)
