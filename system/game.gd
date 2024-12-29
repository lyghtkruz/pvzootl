extends Node

## Signals
signal sun

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _squelch_warnings() -> void:
	## Godot warns about unused signals that are declared in a script without being explicitly called
	## This is to remove those warnings from the error tab
	if true:
		return
	
	sun.emit()
