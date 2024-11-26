extends CanvasLayer

signal scene_hidden

@onready var window_size = get_viewport().get_visible_rect().size

func _ready():
	$Right.position.x = window_size.x /2.0

func start_transition():
	# optional - block mouse inputs 
	$Control.mouse_filter = Control.MOUSE_FILTER_STOP
	
	# take screenshot of the whole screen and convert it because I don't have 
	# a clue what the default format is
	var tex = get_viewport().get_texture().get_image()
	tex.convert(Image.FORMAT_RGBA8)
	
	# Slice the screenshot in 2 parts for each side of the screen
	var left_image = Image.new().create_empty(window_size.x/2, window_size.y,false, Image.FORMAT_RGBA8)
	var right_image = Image.new().create_empty(window_size.x/2, window_size.y,false, Image.FORMAT_RGBA8)
	var src_rect_left = Rect2i(Vector2i(0,0), Vector2i(window_size.x/2, window_size.y))
	var src_rect_right = Rect2i(Vector2i(window_size.x/2,0), Vector2i(window_size.x/2, window_size.y))
	left_image.blit_rect(tex, src_rect_left, Vector2i(0,0))
	right_image.blit_rect(tex, src_rect_right, Vector2i(0,0))
	
	# Apply the 2 new screenshots part as sprite on the screen and make them visible 
	# to hide the game
	$Left.texture = ImageTexture.create_from_image(left_image)
	$Right.texture = ImageTexture.create_from_image(right_image)
	$Left.visible = true
	$Right.visible = true
	
	# optional - notify that the scene is hidden
	scene_hidden.emit()
	
	# optional - wait to increase tension of the player
	await get_tree().create_timer(0.5).timeout
	
	# make the 2 sprites move appart, revealing the game again
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.set_parallel(false)
	tween.tween_property($Left, "position:x", $Left.position.x-window_size.x/2, 0.5)
	tween.set_parallel(true)
	tween.tween_property($Right, "position:x", $Right.position.x+window_size.x/2, 0.5)
