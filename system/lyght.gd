class_name lyght

static func get_visible_rect(texture: Texture2D) -> Rect2:
	# Gets the top left Vector2 and the image size
	# and returns it as a Rect2
	var image = texture.get_image()
	var width = image.get_width()
	var height = image.get_height()
	var min_x = width
	var min_y = height
	var max_x = 0
	var max_y = 0
	
	for y in range(height):
		for x in range(width):
			var color = image.get_pixel(x, y)
			if color.a > 0:
				min_x = min(min_x, x)
				min_y = min(min_y, y)
				max_x = max(max_x, x)
				max_y = max(max_y, y)
	
	if min_x > max_x or min_y > max_y:
		return Rect2(
			Vector2.ZERO,
			Vector2(width, height)
		)    
	return Rect2(
		min_x,
		min_y,
		(max_x - min_x + 1),
		(max_y - min_y + 1)
	)
