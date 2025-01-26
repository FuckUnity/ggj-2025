extends Node2D


const ROTATION_MIN = -100.0
const ROTATION_MAX = -50.0
const MOVEMENT_RATE_MIN = 70.0
const MOVEMENT_RATE_MAX = 80.0


var rng = RandomNumberGenerator.new()
var movement_rate = rng.randf_range(MOVEMENT_RATE_MIN, MOVEMENT_RATE_MAX)
var movement = 0
var rot = rng.randf_range(ROTATION_MIN, ROTATION_MAX)
	
func _process(delta: float) -> void:
	if movement == 0:
		movement = movement_rate
		
	if rot > ROTATION_MAX && movement > 0:
		movement = -1 * movement_rate
		
	if rot < ROTATION_MIN && movement < 0:
		movement = +1 * movement_rate
		
	rot += movement * delta 
	$TextureRect.rotation_degrees = rot
	
