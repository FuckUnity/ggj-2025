extends Bubble

const Bubble = preload("res://level/rainbow_sort/bubble.gd")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	frame = 0
	
func on_empty() -> void:
	pop()
	
func register(m : Person) -> void:
	meeples += 1
	
func deregister():
	super.deregister()
	if meeples <= 0:
		on_empty()
