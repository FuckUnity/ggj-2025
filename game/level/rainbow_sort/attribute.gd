extends Sprite2D

const PeerBubble = preload("res://level/rainbow_sort/peer_bubble.gd")
const RGame = preload("res://level/rainbow_sort/rainbow_game.gd")
const Attributes = preload("res://level/rainbow_sort/attributes.gd").Attributes

var bubble : PeerBubble

var active = true
var game : RGame
@export var attribute : Attributes

func _input(event):	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		if get_rect().has_point(to_local(event.position)):
			game.activate(attribute)
			active = false
			

func _ready() -> void:
	game = $"../../.."
