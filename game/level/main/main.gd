extends level_base

# const cursor_paw = preload("res://assets/tiny_paw.png")

const speeker_01 = preload("res://assets/stage/speaker_01.png")
const speeker_02 = preload("res://assets/stage/speaker_02.png")


@export var shader_disabled: ShaderMaterial
@export var shader_hover: ShaderMaterial

var completed: bool = false
var buttons

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	# Input.set_custom_mouse_cursor(cursor_paw, 0, Vector2(32, 32))
	
	buttons = [
		{ "button": $"Control/AspectRatioContainer/Control/ButtonBubble00",  "level": 0 },
		{ "button": $"Control/AspectRatioContainer/Control/ButtonBubble01",  "level": 1 },
		{ "button": $"Control/AspectRatioContainer/Control/ButtonBubble02",  "level": 2 },
		{ "button": $"Control/AspectRatioContainer/Control/ButtonBubble03",  "level": 3 },
		{ "button": $"Control/AspectRatioContainer/Control/ButtonBubble04",  "level": 4 },
	]
	
	for b in buttons:
		_init_button(b)

func _init_button(b):
	b.button.pressed.connect(func(): if b.level != null and _can_level_be_opened(b.level): game._open_level(b.level))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for button in buttons: 
		if _can_level_be_opened(button.level):
			if button.button.is_hovered():
				button.button.material = shader_hover
			else:
				button.button.material = null
		else:
			button.button.material = shader_disabled
			
	if !completed && game.state.completed:
		_show_game_completed()

func _can_level_be_opened(level) -> bool:
	return game.state.is_level_open_allowed(level)

func _show_game_completed():
	completed = true
	# @todo show completed dialog / speach-bubble?
