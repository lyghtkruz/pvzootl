extends Node

const DIR: Array[int] = [ -1, 1 ]

func spawn():
	var item: Sprite2D = get_parent()
	var direction = DIR.pick_random()
	var offset: Vector2 = Vector2(randi_range(-5, 5), randi_range(-5, 5))
	var start_position = item.global_position + offset
	var peak_height = start_position.y - randi_range(50, 70)
	var end_position = start_position + Vector2(direction * randi_range(15, 30), 0.0)
	var horizontal_distance = start_position.distance_to(end_position)
	var halfway = start_position.x + ( direction * (horizontal_distance / 2))
	var duration = 0.25

	var tween = create_tween()
	tween.tween_property(item, "global_position:y", peak_height, duration).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(item, "global_position:x", halfway, duration).set_ease(Tween.EASE_OUT)
	tween.tween_property(item, "global_position:y", start_position.y, duration).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(item, "global_position:x", end_position.x, duration).set_ease(Tween.EASE_IN)
