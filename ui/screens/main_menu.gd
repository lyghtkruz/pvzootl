extends Control

const TEST_LEVEL: PackedScene = preload("res://levels/test_level.tscn")

signal achievements
signal minigames
signal options
signal start

func _ready() -> void:
	achievements.connect(_achievements)
	minigames.connect(_minigames)
	options.connect(_options)
	start.connect(_start)

func _achievements() -> void:
	print("Clicked Achievements")

func _minigames() -> void:
	print("Clicked Minigames")

func _options() -> void:
	print("Clicked Options")

func _start() -> void:
	get_tree().change_scene_to_packed(TEST_LEVEL)

func z_squelch_warnings() -> void:
	achievements.emit()
	minigames.emit()
	options.emit()
	start.emit()
