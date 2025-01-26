extends Bubble

const Bubble = preload("res://level/rainbow_sort/bubble.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame = 0
	
func on_empty() -> void:
	pop()
