extends Sprite2D

enum Attributes {
	Lone, 			#0
	Wheelchair,		#1
	Guitar,			#2
	Family,			#3
	Pets,			#4
	Poor,			#5
	Glasses,		#6
	War,			#7
	Lila,			#8
	Pink,			#9
	Teal,			#10
	Petrol,			#11
	Orange			#12
}

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
