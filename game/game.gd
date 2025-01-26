class_name Game extends Node

const Assets = preload("res://logic/Assets.gd")
const GameState = preload("res://logic/GameState.gd")
const cursor = preload("res://assets/_main/cursor.png")

var assets: Assets
var state: GameState

@export var init_level: int = -1
@export var levels: Array[PackedScene] 

# Called when the node enters the scene tree for the first time.
func _ready():
	assets = Assets.new()
	state = GameState.new(levels)
	
	_init_level();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	_double_esc -= _delta
	pass
	
func _init_level():
	_open_level(init_level)
	
func close_current_level():
	if !state.current_level_ref:
		return
		
	remove_child(state.current_level_ref)
	_open_level(-1)
	
	
func _open_level(level: int):
	if !state.is_level_open_allowed(level):
		return;
	
	Input.set_custom_mouse_cursor(cursor)
	
	if state.current_level == -1 and state.current_level_ref:
		remove_child(state.current_level_ref)
	
	var level_scene = state.get_scene(level, assets.template_level_main)
	if not level_scene: 
		level_scene = assets.template_level_main
		print("Tried to load non existing level")
		
	state.set_level(level, assets.spawn_level(self, level_scene))

var _double_esc: float = 0

func _unhandled_input(event):
	if Input.is_action_pressed("close"):
		if _double_esc > 0:
			get_tree().quit()
		else:
			_double_esc = 0.3
	
	if !OS.is_debug_build():
		return
	
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_0:
			state.debug_override_level_allowed = !state.debug_override_level_allowed
