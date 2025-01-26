extends Bubble

const Bubble = preload("res://level/rainbow_sort/bubble.gd")

func spawn() -> void:
	frame = 0

func _ready() -> void:
	frame = 5
