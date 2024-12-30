extends Node

@export var dance_speed: float = 0.25
@onready var plant: Sprite2D
var original_scale: Vector2
var original_pos: Vector2
var tween: Tween
var isDancing: bool = false

func _ready() -> void:
	plant = get_parent()
	original_scale = plant.scale
	original_pos = plant.position
	_setup_dance_tween()

func _setup_dance_tween() -> void:
	tween = get_tree().create_tween()
	
	# stretch scales
	var upper_left_scale = Vector2(original_scale.x * 1.2, original_scale.y * 1.1)
	var upper_right_scale = Vector2(original_scale.x * 1.1, original_scale.y * 1.2)
	
	# Define skew degrees
	var skew_left: float = deg_to_rad(-12.0)
	var skew_right: float = deg_to_rad(6.0)
	
	# Offset required to anchor plant
	var position_adjust_left = Vector2(-5.0, -4.0)
	var position_adjust_right = Vector2(5.0, -6.0)

	# Add tween steps for dancing
	tween.tween_property(plant, "scale", upper_left_scale, dance_speed).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(plant, "skew", skew_left, dance_speed).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(plant, "position", plant.position + position_adjust_left, dance_speed).set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(plant, "scale", original_scale, dance_speed).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(plant, "skew", deg_to_rad(0.0), dance_speed).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(plant, "position", original_pos, dance_speed).set_trans(Tween.TRANS_SINE)

	tween.tween_property(plant, "scale", upper_right_scale, dance_speed).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(plant, "skew", skew_right, dance_speed).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(plant, "position", plant.position + position_adjust_right, dance_speed).set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(plant, "scale", original_scale, dance_speed).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(plant, "skew", deg_to_rad(0.0), dance_speed).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(plant, "position", original_pos, dance_speed).set_trans(Tween.TRANS_SINE)

	tween.set_loops()

func dance() -> void:
	print("Dancing on ", get_parent().name)
	if isDancing:
		return
	
	isDancing = true
	tween.play()

func stop() -> void:
	print("trying to stop ", get_parent().name)
	if not isDancing:
		print("I wasn't dancing?")
		return
	
	isDancing = false	
	tween.stop()
	plant.scale = original_scale
