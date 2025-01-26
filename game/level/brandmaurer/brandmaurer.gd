class_name Brandmaurer extends level_base

@export var level_time: int = 60

@export var bricks: Array[PackedScene]
@export var brick_spawner: Node3D

@export var start_label: Label3D
@export var end_label: Label3D

@export var spot_light: SpotLight3D

var current_tween: Tween

func _ready() -> void:
	super()
	
	var tween = create_tween()
	for i in range(20):
		tween.tween_interval(randf() / 2)
		tween.tween_callback(spawn_brick)
		
	tween.tween_callback(start_label.set_visible.bind(false))
	tween.tween_callback(_spawn_brick_loop)
	
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", on_timeout)
	timer.start(level_time)
	
func _spawn_brick_loop() -> void:
	current_tween = create_tween()
	current_tween.tween_interval(randf() * 10)
	current_tween.tween_callback(spawn_brick)
	current_tween.tween_callback(_spawn_brick_loop)

func on_timeout():
	end_label.set_visible(true)
	spot_light.light_color = Color("ff7c6c")
	var tween = create_tween()
	tween.tween_interval(10)
	tween.tween_callback(complete)

func spawn_brick():
	var brick_instance = bricks.pick_random().instantiate() as RigidBody3D
	brick_instance.position = brick_spawner.position + Vector3((randf() - 0.5) * 4, 0, 0)
	add_child(brick_instance)
