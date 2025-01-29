extends level_base

func _ready():
	super._ready()

func _process(delta: float) -> void:
	if ($game/Lila/bubble.frame == 5 && 
		$game/Pink/bubble.frame == 5 &&
		$game/Teal/bubble.frame == 5 &&
		$game/Petrol/bubble.frame == 5 &&
		$game/Orange/bubble.frame == 5 &&
		$game.all_done_mobving()):
			var tween = create_tween()
			tween.tween_interval(3)
			tween.tween_callback(complete)
