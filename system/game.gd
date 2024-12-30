extends Node

var isPlanting: bool = false

## Signals
signal planting
signal sun

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	planting.connect(_planting)
	isPlanting = true

func _planting(enter: bool) -> void:
	if enter:
		_start_planting()
		return
	_stop_planting()

func _start_planting() -> void:
	isPlanting = true

func _stop_planting() -> void:
	isPlanting = false

func _squelch_warnings() -> void:
	## Godot warns about unused signals that are declared in a script without being explicitly called
	## This is to remove those warnings from the error tab
	if true:
		return
	
	planting.emit()
	sun.emit()
