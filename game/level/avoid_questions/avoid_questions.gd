extends level_base

var _is_complete = false

func _on_complete():
	if _is_complete: 
		return
		
	_is_complete = true
	var tween = create_tween()
	tween.tween_interval(2)
	tween.tween_callback(complete)
