extends TextureRect

@export var is_pressed = false
@export var unpressed_texture: Texture2D
@export var pressed_texture: Texture2D

@export var papers_root: Node
@export var stamp_decal: PackedScene

func _gui_input(event: InputEvent) -> void:
	if event.is_pressed():
		accept_event()
		is_pressed = true
		self.texture = pressed_texture
		check_document_to_stamp()
	elif is_pressed and event.is_released():
		is_pressed = false
		self.texture = unpressed_texture
	pass

func check_document_to_stamp():
	var papers = papers_root.get_children()
	for paper in papers.filter(func(p): return p is Paper):
		var intersection = Rect2(((paper as Paper).get_node(^"Sprite2D") as Sprite2D).global_position, 
			((paper as Paper).get_node(^"Sprite2D") as Sprite2D).get_viewport_rect().size).intersection(get_global_rect())
		print(get_global_rect())
		print(((paper as Paper).get_node(^"Sprite2D") as Sprite2D).get_viewport_rect())
		if intersection.size.x * intersection.size.y > (get_global_rect().size.x * get_global_rect().size.y) * 0.2:
			print("STAMP" + str(intersection.position))
			var decal = stamp_decal.instantiate()
			paper.add_child(decal)
			(decal as Node2D).global_position = intersection.position
