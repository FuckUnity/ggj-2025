extends Sprite2D

const Attributes = preload("res://level/rainbow_sort/attributes.gd").Attributes


var places = {
	'lone': ""
}

@export var party : Attributes

@export var attributes : Array[Attributes]

var initial_position : Vector2

var cur_bubble : Attributes

var moving : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moving = false
	initial_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
