extends Camera3D

@export var brick_spawn: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var drag_start_object_pos: Vector3
var drag_target: RigidBody3D

func _input(event: InputEvent) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var from = project_ray_origin(mouse_pos)
	var ray_length = 100
	var to = from + project_ray_normal(mouse_pos) * ray_length
	
	if event is InputEventMouseButton and event.is_pressed():
		var space = get_world_3d().direct_space_state
		var ray_query = PhysicsRayQueryParameters3D.new()
		ray_query.from = from
		ray_query.to = to
		ray_query.collision_mask = 1 | 2
		ray_query.collide_with_areas = true
		var raycast_result = space.intersect_ray(ray_query)
		if raycast_result.has("collider") and raycast_result.collider is RigidBody3D:
			drag_start_object_pos = raycast_result.collider.position
			drag_target = raycast_result.collider
			drag_target.freeze = true
			drag_target.physics_material_override = drag_target.physics_material_override.duplicate(true)
			drag_target.physics_material_override.bounce = 1
			drag_target.physics_material_override.friction = 0


	if drag_target != null and event is InputEventMouseButton and !event.is_pressed():
		drag_start_object_pos = Vector3()
		drag_target.freeze = false	
		drag_target.physics_material_override.bounce = 0.2
		drag_target.physics_material_override.friction = 0.7
		drag_target = null

	if drag_target != null and event is InputEventMouseMotion:
		var movement_plane = Plane(global_position * Vector3.FORWARD, brick_spawn.position)
		var move_to = movement_plane.intersects_ray(from, to)
		drag_target.move_and_collide(move_to - drag_target.position, false, 0.1)
		drag_target.rotation = Vector3.ZERO
		
