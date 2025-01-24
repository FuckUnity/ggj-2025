class_name LevelScene extends Object

const GameState = preload("res://logic/GameState.gd")

var scene: PackedScene
var state: GameState.MiniGameState = GameState.MiniGameState.BLOCKED

func _init(a_scene: PackedScene) -> void:
	scene = a_scene
