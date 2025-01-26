extends CharacterBody2D

#player movement variables
@export var gravity = 800

@export var SPEED = 800.0
@export var JUMP_VELOCITY = -1200.0

@export var body: AnimatedSprite2D
@export var head_normal: AnimatedSprite2D
@export var head_eyepatch: AnimatedSprite2D

var start_pos = null
var has_eye_patch = false
var is_ready = false

func _reset():
	has_eye_patch = false
	position = start_pos
	head_normal.visible = true
	head_eyepatch.visible = false
	
	var flipped = false
	head_normal.flip_h = flipped
	head_eyepatch.flip_h = flipped
	body.flip_h = flipped
	$JumpIndicator.flipped = flipped
	
func _get_black_eye():
	has_eye_patch = true
	head_eyepatch.visible = true
	head_normal.visible = false

func _ready():
	start_pos = position
	_reset()
	is_ready = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_released("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	elif not is_on_floor():
		pass
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if not is_on_floor():
		_set_animation("jump")
	
	if direction != 0:
		if is_on_floor():
			_set_animation("walk")
			
		var flipped = direction < 0
	
		head_normal.flip_h = flipped
		head_eyepatch.flip_h = flipped
		body.flip_h = flipped
		$JumpIndicator.flipped = flipped

	#on idle if nothing is being pressed
	if is_on_floor() and !Input.is_anything_pressed():
		_set_animation("default")

	move_and_slide()

func _set_animation(name: String):
	head_normal.play(name)
	head_eyepatch.play(name)
	body.play(name)

func _on_plant_area_entered(body):
	pass

func _on_plant_dead_area_entered(body):
	if body == self:
		if has_eye_patch:
			_reset()
		else:
			_get_black_eye()

signal completed

func _on_finish_entered(body):
	if body == self:
		print("olaf::_on_finish_entered")
		completed.emit()
