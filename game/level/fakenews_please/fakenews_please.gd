class_name FakenewsPlease extends level_base

@export var paper_spawn_pos: Vector2

@export var customers: Array[Customer] = []
@export var paper_prefab: PackedScene
@export var customer_sprite: Sprite2D

@export var customer_start: Vector2
@export var customer_end: Vector2

@export var response_label: RichTextLabel
@export var response_confirm: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_next_customer()
	response_confirm.connect("pressed", on_confirm_response)
	(response_confirm.get_parent() as Sprite2D).set_visible(false)

func play_next_customer():
	var customer = customers[0];
	customer_sprite.texture = customer.person_texture
	customer_sprite.position = customer_start
	var tween = create_tween()
	tween.tween_property(customer_sprite, "position", customer_end, 2).set_ease(Tween.EASE_IN_OUT)
	tween.tween_interval(0.5)
	tween.tween_callback(put_paper.bind(customer))
	
	customers.remove_at(0)

func put_paper(customer: Customer):
	var paper = paper_prefab.instantiate()
	paper.global_position = paper_spawn_pos
	paper.init(customer)
	$"CanvasLayer/Papers".add_child(paper)

func hand_back(paper: Paper):
	(response_confirm.get_parent() as Sprite2D).set_visible(true)
	if paper.paper_state == paper.customer.is_fake:
		response_label.text = "Correct, that was fake, or not trustworthy news!"
	else:
		response_label.text = paper.customer.failure_message
	remove_child(paper)
	paper.queue_free()

func on_confirm_response():
	(response_confirm.get_parent() as Sprite2D).set_visible(false)
	response_label.text = ""
	
	var tween = create_tween()
	tween.tween_property(customer_sprite, "position", customer_start, 2).set_ease(Tween.EASE_IN_OUT)
	tween.tween_interval(2)
	tween.tween_callback(next_or_end)
	
func next_or_end():
	if customers.size() > 0:
		play_next_customer()
	else:
		complete()
