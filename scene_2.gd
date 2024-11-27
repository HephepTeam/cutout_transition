extends CanvasLayer

const SPEED = 30
var turning = true

func _process(delta):
	if turning:
		$Icon.skew += delta * SPEED


func _on_button_pressed() -> void:
	turning = false
