extends AnimatedSprite2D

const Attributes = preload("res://level/rainbow_sort/attributes.gd").Attributes
const Person = preload("res://level/rainbow_sort/person.gd")

var positions : Array[Vector2]

var attributes : Array[Attributes]

@export var meeples : int

func pop() -> void:
	if frame != 0: return
	play("default")
	attributes = []

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	positions = [
		global_position + Vector2(0, 0),
		global_position + Vector2(10, 45.5),
		global_position + Vector2(40, 20),
		global_position + Vector2(-10, 10.5),
		global_position + Vector2(-20, -5),
		global_position + Vector2(5, -15),
		global_position + Vector2(-8.5, -30.5),
		global_position + Vector2(-26, -22.5),
		global_position + Vector2(-31, 1),
		global_position + Vector2(-24.5, 20.5),
		global_position + Vector2(-7.5, 36.5),
		global_position + Vector2(18.5, 40.5),
	]
	attributes = []
	

func register(m : Person):
	if attributes.size() >= 4: return
	if attributes.has(m.party): return
	attributes.push_back(m.party)

func deregister():
	meeples -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
