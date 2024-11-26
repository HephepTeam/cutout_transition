extends CanvasLayer

const SPEED = 30

func _process(delta):
	$Icon.skew += delta * SPEED
