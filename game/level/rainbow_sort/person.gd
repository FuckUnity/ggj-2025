extends Sprite2D

enum COLOR {
	BLUE,
	RED,
	YELLOW,
	GREEN,
	PURPLE,
	RAINBOW	
}

@export var alignment : COLOR

func _change_color(color: COLOR) -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
