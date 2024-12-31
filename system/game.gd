extends Node

var isPlanting: bool = false

## Signals
signal planting
signal sun
signal snap

var plantingScene: Sprite2D
var plant_area: Node2D
var projectiles_area: Node2D

func _ready() -> void:
	planting.connect(_planting)
	isPlanting = false

func _planting() -> void:
	isPlanting = true

func _squelch_warnings() -> void:
	## Godot warns about unused signals that are declared in a script without being explicitly called
	## This is to remove those warnings from the error tab
	if true:
		return
	
	planting.emit()
	snap.emit()
	sun.emit()
