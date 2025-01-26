class_name Brandmaurer extends level_base

@export var brick: PackedScene
@export var brick_spawner: Node3D
@export var end_label: Label3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	
	var tween = create_tween()
	for i in range(20):
		tween.tween_interval(randf())
		tween.tween_callback(spawn_brick)
	
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", on_timeout)
	timer.start(60)
	
func on_timeout():
	end_label.set_visible(true)
	var tween = create_tween()
	tween.tween_interval(10)
	tween.tween_callback(complete)

func spawn_brick():
	var brick_instance = brick.instantiate() as RigidBody3D
	brick_instance.position = brick_spawner.position + Vector3((randf() - 0.5) * 4, 0, 0)
	add_child(brick_instance)
