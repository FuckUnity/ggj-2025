extends level_base

var cursor_cake = load("res://assets/give_them_cake/cursor.png")
const template_bird = preload("res://level/give_them_cake/lindner.tscn")
# var template_point = preload("res://level/moorhuhn/point.tscn")

var bpm = 20.0
var rng = RandomNumberGenerator.new()

var birds = [] as Array[Lindner]
var max_birds = 10
var max_points = 10
var bird_holder: Node
var points_holder: Node
var points_visual: Control

var _points_to_spawn = 0

var _next_point_spanw_in_s = 0
var _next_bird_spawn_in_s = 0.0

var _points = 200
const point_multiplicator = 10
const points_scale = 2.5

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	bird_holder = $"./BirdHolder"
	points_holder = $"./PointsHolder"
	points_visual = $"Control2/AspectRatioContainer/Control/PointsHolder/Points"
	Input.set_custom_mouse_cursor(cursor_cake, 0, Vector2(128, 128))

func _physics_process(delta):
	_next_bird_spawn_in_s = _next_bird_spawn_in_s - delta
	
	_handle_birds()
	_handle_game_end()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	points_visual.size.y = _points
	
func _input(event):
	if !event is InputEventMouseButton:
		return
		
	if event.button_index != MOUSE_BUTTON_LEFT or !event.pressed:
		return
			
	# $"AudioStreamClick".play()
	var pos = get_viewport().get_camera_2d().get_local_mouse_position()
	
	for bird in birds:
		var precision = bird.was_hit(pos)
		if precision > 0:
			bird.killed()
			_add_points(precision)

func _handle_game_end():
	if _points < 5 * point_multiplicator:
		complete()

func _handle_birds():
	if _next_bird_spawn_in_s < 0.0 and birds.size() < max_birds:
		_next_bird_spawn_in_s = ((1 / bpm) + rng.randf_range(-0.02, 0.02)) * 60.0
		var bird = game.assets.spawn_new(bird_holder, template_bird)
		bird.set_start(rng)
		birds.push_back(bird)
		
	_remove_unused_birds()

func _remove_unused_birds():
	var toDel = []
	
	for bird in birds:
		if bird.state == Lindner.State.DELETABLE:
			toDel.push_back(bird)
	
	for bird in toDel:
		birds.erase(bird)
		bird_holder.remove_child(bird)

func _add_points(points: int):
	_points -= points * points_scale
