extends Bubble

const Bubble = preload("res://level/rainbow_sort/bubble.gd")

var spawned = false

var inside : Array[Person]

func spawn() -> void:
	frame = 0
	spawned = true

func get_party_bubble(a: Attributes) -> Bubble:
	Attributes.Petrol
	match a:
		Attributes.Lila:   return $"../../Lila/bubble"
		Attributes.Pink:   return $"../../Pink/bubble"
		Attributes.Teal:   return $"../../Teal/bubble"
		Attributes.Petrol: return $"../../Petrol/bubble"
		Attributes.Orange: return $"../../Orange/bubble"
		_: return $Orange/bubble

func pop() -> void:
	super.pop()
	$icon.active = true
	for m in inside:
		m.move_home()
		m.callback = get_party_bubble(m.party).register
		m.rainbow = true
	
func register(m: Person) -> void:
	super.register(m)
	inside.push_back(m)
	

func _ready() -> void:
	super._ready()
	frame = 5
	inside = []

func _process(delta: float) -> void:
	if attributes.size() >= 4:
		spawn()

func _input(event: InputEvent) -> void:
	if inside.size() == 0: return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
		if $icon.get_rect().has_point(to_local(event.position)):
			pop()
			spawned = false
			attributes = []
