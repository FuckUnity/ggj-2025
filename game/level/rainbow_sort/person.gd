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

var fake : bool

var area2d : Area2D

var callback : Callable
var rainbow : bool

const SPEED = 250.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moving = false
	fake = false
	initial_position = global_position
	goal_position = initial_position
	area2d = $Area2D
	rainbow = false


func move_to(goal: Vector2) -> void:
	goal_position = goal
	rainbow = true
	
func move_to_fake():
	goal_position = Vector2(500, 540)
	fake = true
	
func move_home():
	goal_position = initial_position
	rainbow = false

func has_attr(attr: Attributes) -> bool:
	var has = false
	for a in attributes:
		if a == attr: return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if fake && global_position == goal_position:
		move_home()		
		fake = false
		return
		
	if rainbow && global_position == goal_position:
		callback.call(self)
		rainbow = false
	
	if global_position == goal_position:
		return
		
	var destination = goal_position
	var distance_to_destination
	var distance_to_move
	if global_position != destination: # only move if we aren't there
		distance_to_destination = global_position.distance_to(destination)
		distance_to_move = SPEED * delta
		if abs(distance_to_destination) < abs(distance_to_move): # if we are close, just move to destination
			distance_to_move = distance_to_destination
		global_position += global_position.direction_to(destination) * distance_to_move
		
