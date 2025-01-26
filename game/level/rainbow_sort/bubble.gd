extends AnimatedSprite2D

var positions : Array[Vector2]

func pop() -> void:
	if frame != 0: return
	play("default")

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	positions = [
		global_position + Vector2(0, 0),
		global_position + Vector2(168, 45.5),
		global_position + Vector2(72, 218),
		global_position + Vector2(-127, 168.5),
		global_position + Vector2(-186, -72),
		global_position + Vector2(50, -182),
		global_position + Vector2(-81.5, -286.5),
		global_position + Vector2(-268, -222.5),
		global_position + Vector2(-331.818, 18),
		global_position + Vector2(-245.5, 204.5),
		global_position + Vector2(-77.5, 368.5),
		global_position + Vector2(186.5, 400.5),
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
