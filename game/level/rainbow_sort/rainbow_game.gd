extends Node2D

const Person = preload("res://level/rainbow_sort/person.gd")
const Bubble = preload("res://level/rainbow_sort/bubble.gd")
const Attributes = preload("res://level/rainbow_sort/attributes.gd").Attributes

var meeples : Array[Person]

var bubbles : Array[Bubble]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	meeples = [
		# Lila
		$Lila/Person,
		$Lila/Person2,
		$Lila/Person3,
		$Lila/Person4,
		$Lila/Person5,
		# Pink
		$Pink/Person,
		$Pink/Person2,
		$Pink/Person3,
		$Pink/Person4,
		$Pink/Person5,
		$Pink/Person6,
		# Teal
		$Teal/Person,
		$Teal/Person2,
		$Teal/Person3,
		$Teal/Person4,
		$Teal/Person5,
		# Petrol
		$Petrol/Person,
		$Petrol/Person2,
		$Petrol/Person3,
		$Petrol/Person4,
		$Petrol/Person5,
		$Petrol/Person6,
		$Petrol/Person7,
		# Orange
		$Orange/Person,
		$Orange/Person2,
		$Orange/Person3,
		$Orange/Person4,
		$Orange/Person5,
		$Orange/Person6
	]
	bubbles = [
		$lone_parent/bubble,
		$wheelchair/bubble,
		$guitar/bubble,
		$family/bubble,
		$pets/bubble,
		$poor/bubble,
		$glasses/bubble,
		$war/bubble
	]

var meeple_to_send : Array[Person]

func activate(attr: Attributes) -> void:
	var count = 0
	meeple_to_send = []
	for  meeple in meeples:
		if meeple.moving:
			continue
		if meeple.global_position != meeple.initial_position:
			continue
		if meeple.has_attr(attr):
			meeple_to_send.push_back(meeple)
			count += 1
	if count <= 3:		
		for m in meeple_to_send:
			m.move_to_fake()
		return
	
	var a_bubble = bubbles[attr]
	for m in meeple_to_send:
		var i = count % a_bubble.positions.size()
		m.move_to(a_bubble.positions[i])
		get_party_bubble(m.party).deregister()
		m.callback = a_bubble.register
		count -= 1
		

func get_party_bubble(a: Attributes) -> Bubble:
	Attributes.Petrol
	match a:
		Attributes.Lila:   return $Lila/bubble
		Attributes.Pink:   return $Pink/bubble
		Attributes.Teal:   return $Teal/bubble
		Attributes.Petrol: return $Petrol/bubble
		Attributes.Orange: return $Orange/bubble
		_: return $Orange/bubble

func all_done_mobving() -> bool:
	for m in meeples:
		if m.moving: return false
	return true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
