class_name MerzSpawner extends Node3D

@export var merz_kapsel: PackedScene

@export var textures: Array[Texture2D] = []

func _ready() -> void:
	var tween = create_tween()
	tween.tween_interval(10 + randf() * 10)
	tween.tween_callback(spawn_merz)

func spawn_merz():
	var merz = merz_kapsel.instantiate() as RigidBody3D
	add_child(merz)
	merz.position = position + Vector3((randf() * 4) - 2, 0, 0)
	merz.apply_central_force(Vector3(0, 100 + randf() * 100, -3000 + (randf() * -5000)))
	var mesh = merz.get_node(^"./CollisionShape3D/MeshInstance3D") as MeshInstance3D
	var mat = (mesh.get_surface_override_material(0) as StandardMaterial3D).duplicate(true)
	mat.albedo_texture = textures.pick_random()
	mesh.set_surface_override_material(0, mat)
	
	var tween = create_tween()
	tween.tween_interval(5 + randf() * 5)
	tween.tween_callback(spawn_merz)
