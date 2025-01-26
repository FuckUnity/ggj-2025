class_name Assets extends Object

const template_level_main = preload("res://level/main/main.tscn")

func spawn_new(on: Node, template: Resource, pos:Vector2 = Vector2()):
	var newInstance = template.instantiate()
	on.add_child(newInstance)
	if !(newInstance is CanvasLayer):
		newInstance.position = pos
	return newInstance

func spawn_level(on: Node, template: Resource):
	var newInstance = template.instantiate()
	on.add_child(newInstance)
	return newInstance
