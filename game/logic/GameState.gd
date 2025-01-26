class_name GameState extends Object

enum MiniGameState { ACTIVE, BLOCKED, COMPLETED }

const LevelScene = preload("res://logic/LevelScene.gd")

var current_level_ref: Node
var debug_override_level_allowed = false

var current_level: int = -1
var completed: bool = false

var _levels: Array[LevelScene] = []
var _lastLevel: int

func _init(scenes: Array[PackedScene]) -> void:
	for scene in scenes:
		_levels.push_back(LevelScene.new(scene))
		
	_levels[0].state = MiniGameState.ACTIVE
	_levels[1].state = MiniGameState.ACTIVE
	_lastLevel = _levels.size() - 1

func complete_current_level() -> void:
	var level = current_level
	
	_levels[level].state = MiniGameState.COMPLETED
	
	if level == _lastLevel:
		completed = true
	else:
		_levels[level + 1].state = MiniGameState.ACTIVE

func set_level(level: int, level_ref: Node):
	current_level = level
	current_level_ref = level_ref
	
func get_scene(level: int, default_scene: PackedScene) -> PackedScene:
	if level < 0 || level > _lastLevel: return default_scene
	return _levels[level].scene
	
func is_level_open_allowed(level: int) -> bool:
	if level < 0 or debug_override_level_allowed:
		return true
		
	if level > _lastLevel: 
		return false
		
	var state = _levels[level].state
	return state == MiniGameState.ACTIVE || state == MiniGameState.COMPLETED
	
func is_level_completed(level: int) -> bool:
	if level > _lastLevel: 
		return false
		
	var state = _levels[level].state
	return state == MiniGameState.COMPLETED
