extends Node2D


func _ready():
	ScreenshotTransition.scene_hidden.connect(_on_scene_hidden)

func _input(event):
	if event is InputEventKey and event.is_pressed():
		ScreenshotTransition.start_transition()

# signal callback reacting to the scene_hidden signal emitted by the transition autoload
func _on_scene_hidden():
	$Scene1.visible = false
