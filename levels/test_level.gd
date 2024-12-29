extends Node2D

var sun_scene: PackedScene = preload("res://clickable/items/sun.tscn")

@onready var timer: Timer = $Timer
@onready var clickables: Node2D = $clickables

func _ready() -> void:
	timer.timeout.connect(_spawn)

func _spawn() -> void:
	var sun = sun_scene.instantiate()
	clickables.add_child(sun)
