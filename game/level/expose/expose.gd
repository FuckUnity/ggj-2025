extends level_base

const party_icons = [
	"res://assets/expose/icons/war.png",
	"res://assets/expose/icons/nature.png",
	"res://assets/expose/icons/temperature_climate.png",
	"res://assets/expose/icons/cross.png",
	"res://assets/expose/icons/¥€$.png",
	"res://assets/expose/icons/communist.png",
	"res://assets/expose/icons/wildfire.png"
]

const argument_icons = [
	"res://assets/expose/icons/glasses.png",
	"res://assets/expose/icons/alleinerziehend.png",
	"res://assets/expose/icons/bankruptcy.png",
	"res://assets/expose/icons/guitar.png",
	"res://assets/expose/icons/wheelchair_placeholer.png",
	"res://assets/expose/icons/wedding.png",
	"res://assets/expose/icons/pets.png",
	"res://assets/expose/icons/nature.png",
	"res://assets/expose/icons/family_kind.png",
	"res://assets/expose/icons/war.png",
	"res://assets/expose/icons/temperature_climate.png",
	"res://assets/expose/icons/child.png"
]

const dialogTree = [
	{
		'Q': [1,4,3],
		'a1': 2,
		'a2': 1,
		'a3': 1
	},
	{
		'Q': [1,3,5],
		'a1': 3,
		'a2': 2,
		'a3': 1
	},
	{
		'Q': [5,4,6],
		'a1': 1,
		'a2': 1,
		'a3': 4
	},
	{
		'Q': [3,2,1],
		'a1': 3,
		'a2': 3,
		'a3': 5
	},
	{
		'Q': [6,4,0],
		'a1': 3,
		'a2': 2,
		'a3': 6
	},
	{
		'Q': [0,6,0],
		'a1': 7,
		'a2': 4,
		'a3': 1
	},
	{
		'Q': [0,0,0],
		'a1': 8,
		'a2': 8,
		'a3': 8
	}
]

var current_level = 0
@export var arm_move_amount = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	_init_q(1)

func _init_q(nr):
	if nr == 7:
		$treat/arm.queue_free()
	if nr == 8:
		complete()
		return
	nr -= 1 # index ist 0 based
	current_level = nr
	$contanier/Q.text = dialogTree[nr].Q
	

func _on_a_1_pressed():
	var next = dialogTree[current_level].a1
	_init_q(next)

func _on_a_2_pressed():
	var next = dialogTree[current_level].a2
	_init_q(next)

func _on_a_3_pressed():
	var next = dialogTree[current_level].a3
	_init_q(next)
