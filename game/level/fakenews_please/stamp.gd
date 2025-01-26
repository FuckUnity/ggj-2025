extends Sprite2D

@export var is_pressed = false
@export var unpressed_texture: Texture2D
@export var pressed_texture: Texture2D
@export var decal_texture: Texture2D

@export var papers_root: Node

@export var stamp_state: Paper.PaperState

@export var stamp_audio: AudioStreamPlayer

func _draw() -> void:
	draw_rect(Rect2(self.position, Vector2(self.texture.get_width(), self.texture.get_height())), Color.AQUA, true)
	pass


func _process(delta: float) -> void:
	pass

func _get_global_rect():
	var size = self.texture.get_size() * self.global_scale;
	return Rect2(global_position - size / 2, size)

func _input(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return
	var mouseEvent = event as InputEventMouseButton
		
	if event.is_released():
		is_pressed = false
		self.texture = unpressed_texture
		return
	
	if !_get_global_rect().has_point(mouseEvent.global_position):
		return
		
	if mouseEvent.is_pressed():
		is_pressed = true
		self.texture = pressed_texture
		check_document_to_stamp()
		stamp_audio.play()

func check_document_to_stamp():
	var papers = papers_root.get_children()
	for p in papers.filter(func(p): return p is Paper):
		var paper: Paper = p as Paper
		var this_rect = _get_global_rect()
		var paper_rect = paper.get_global_rect()
		var intersection = this_rect.intersection(paper_rect)
		var overlap_significant = intersection.size.x * intersection.size.y > (this_rect.size.x * this_rect.size.y) * 0.2
		
		if overlap_significant:
			_add_decal(paper)
			paper.paper_state = self.stamp_state

func _add_decal(paper: Paper):
	var decal = Sprite2D.new()
	decal.texture = decal_texture
	paper.get_node("./Sprite2D").add_child(decal)
	(decal as Node2D).global_position = global_position
	(decal as Node2D).global_scale = Vector2.ONE
