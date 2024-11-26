extends CanvasLayer

const SPEED = 50

func _process(delta):
	$Icon.rotation_degrees += delta * SPEED
