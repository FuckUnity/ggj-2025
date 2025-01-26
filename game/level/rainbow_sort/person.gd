extends Sprite2D

const Attributes = preload("res://level/rainbow_sort/attributes.gd").Attributes


var places = {
	'lone': ""
}

@export var party : Attributes

@export var attributes : Array[Attributes]

var initial_position : Vector2

var goal_position : Vector2

var cur_bubble : Attributes

var moving : bool

const SPEED = 250.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moving = false
	initial_position = global_position
	goal_position = initial_position


func move_to(goal: Vector2) -> void:
	goal_position = goal

func has_attr(attr: Attributes) -> bool:
	var has = false
	for a in attributes:
		if a == attr: return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var destination = goal_position
	var distance_to_destination
	var distance_to_move
	if global_position != destination: # only move if we aren't there
		distance_to_destination = position.distance_to(destination)
		distance_to_move = SPEED * delta
		if abs(distance_to_destination) < abs(distance_to_move): # if we are close, just move to destination
			distance_to_move = distance_to_destination
		position += position.direction_to(destination) * distance_to_move
