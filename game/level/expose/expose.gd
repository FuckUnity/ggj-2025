extends level_base

const clickable = preload("res://level/expose/clickable.gd")

var a1 : clickable
var a2 : clickable
var a3 : clickable
var q1 : Sprite2D
var q2 : Sprite2D
var q3 : Sprite2D

const party_icons = {
	'war': "res://assets/expose/icons/war.png",
	'nature': "res://assets/expose/icons/nature.png",
	'climate': "res://assets/expose/icons/temperature_climate.png",
	'cross': "res://assets/expose/icons/cross.png",
	'money': "res://assets/expose/icons/¥€$.png",
	'communist': "res://assets/expose/icons/communist.png",
	'wildfire': "res://assets/expose/icons/wildfire.png"
}

const argument_icons = {
	'glasses': "res://assets/expose/icons/glasses.png",      
	'alleinerziehend': "res://assets/expose/icons/alleinerziehend.png",
	'bankrupt': "res://assets/expose/icons/bankruptcy.png",
	'art': "res://assets/expose/icons/guitar.png",                       
	'wheelchair': "res://assets/expose/icons/wheelchair_placeholer.png",
	'wedding': "res://assets/expose/icons/wedding.png",
	'pets': "res://assets/expose/icons/pets.png",
	'nature': "res://assets/expose/icons/nature.png",
	'family': "res://assets/expose/icons/family_kind.png",
	'war': "res://assets/expose/icons/war.png",
	'climate': "res://assets/expose/icons/temperature_climate.png",
	'flag': "res://assets/expose/icons/flagge.png",
	'cake': "res://assets/give_them_cake/cursor.png",
	'oil': "res://assets/expose/icons/oil-barrel.png"
}

const dialogTree = [
	{ #1
		'Q': [party_icons.nature, party_icons.climate, party_icons.money],
		'a1': { 'next': 2, 'icon': argument_icons.bankrupt},
		'a2': { 'next': 1, 'icon': argument_icons.glasses},
		'a3': { 'next': 1, 'icon': argument_icons.nature}
	},
	{ #2
		'Q': [party_icons.cross, party_icons.money, party_icons.climate],
		'a1': { 'next': 3, 'icon': argument_icons.alleinerziehend},
		'a2': { 'next': 2, 'icon': argument_icons.flag},
		'a3': { 'next': 1, 'icon': argument_icons.wedding}
	},
	{ #3
		'Q': [party_icons.communist, party_icons.money, party_icons.wildfire],
		'a1': { 'next': 1, 'icon': argument_icons.climate},
		'a2': { 'next': 4, 'icon': argument_icons.flag},
		'a3': { 'next': 2, 'icon': argument_icons.wheelchair}
	},
	{ #4
		'Q': [party_icons.cross, party_icons.communist ,party_icons.wildfire],
		'a1': { 'next': 3, 'icon': argument_icons.climate},
		'a2': { 'next': 3, 'icon': argument_icons.bankrupt},
		'a3': { 'next': 5, 'icon': argument_icons.pets}
	},
	{ #5
		'Q': [party_icons.money, party_icons.war, party_icons.climate],
		'a1': { 'next': 3, 'icon': argument_icons.climate},
		'a2': { 'next': 2, 'icon': argument_icons.bankrupt},
		'a3': { 'next': 6, 'icon': argument_icons.oil}
	},
	{ #6
		'Q': [party_icons.war,party_icons.money,party_icons.war],
		'a1': { 'next': 7, 'icon': argument_icons.war},
		'a2': { 'next': 4, 'icon': argument_icons.family},
		'a3': { 'next': 1, 'icon': argument_icons.nature}
	},
	{ #7
		'Q': [party_icons.war,party_icons.war,party_icons.war],
		'a1': { 'next': 8, 'icon': argument_icons.cake},
		'a2': { 'next': 8, 'icon': argument_icons.cake},
		'a3': { 'next': 8, 'icon': argument_icons.cake}
	}
]

var current_level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	a1 = $scene/Arguments/a1
	a1.f = _on_a_1_pressed
	a2 = $scene/Arguments/a2
	a2.f = _on_a_2_pressed
	a3 = $scene/Arguments/a3
	a3.f = _on_a_3_pressed
	q1 = $SpeechBubble/Q/q1
	q2 = $SpeechBubble/Q/q2
	q3 = $SpeechBubble/Q/q3
	_init_q(1)

func _init_q(nr):
	if nr == 8:
		complete()
		return
	match nr:
		1: $Start.texture = load("res://assets/stage/IMG_0164.png")
		2: $Start.texture = load("res://assets/stage/IMG_0165.png")
		3: $Start.texture = load("res://assets/stage/IMG_0170.png")
		4: $Start.texture = load("res://assets/stage/IMG_0166.png")
		5: $Start.texture = load("res://assets/stage/IMG_0167.png")
		6: $Start.texture = load("res://assets/stage/IMG_0168.png")
		7: $Start.texture = load("res://assets/stage/IMG_0169.png")
		_: $Start.texture = load("res://assets/stage/IMG_0164.png")
	
	current_level = nr - 1 # index = nr -1
	q1.texture = load(dialogTree[current_level].Q[0])
	q2.texture = load(dialogTree[current_level].Q[1])
	q3.texture = load(dialogTree[current_level].Q[2])
	a1.texture = load(dialogTree[current_level].a1.icon)
	a2.texture = load(dialogTree[current_level].a2.icon)
	a3.texture = load(dialogTree[current_level].a3.icon)
	

func _on_a_1_pressed():
	var next = dialogTree[current_level].a1.next
	_init_q(next)

func _on_a_2_pressed():
	var next = dialogTree[current_level].a2.next
	_init_q(next)

func _on_a_3_pressed():
	var next = dialogTree[current_level].a3.next
	_init_q(next)
