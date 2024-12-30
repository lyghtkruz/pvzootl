extends Node

var sun_scene: PackedScene = preload("res://clickable/items/sun.tscn")

@onready var spawn_timer: Timer
@onready var clickables: Node2D

func _ready() -> void:
	clickables = get_parent().find_child("clickables")
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.one_shot = false
	spawn_timer.wait_time = 10.0
	spawn_timer.timeout.connect(_spawn)
	spawn_timer.start()
	_spawn()

func _spawn() -> void:
	var sun = sun_scene.instantiate()
	clickables.add_child(sun)
