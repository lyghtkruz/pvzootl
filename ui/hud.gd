extends CanvasLayer

@onready var sun_label: Label = $HBoxContainer/sun_label

var sun: int = 0

func _ready() -> void:
	Game.sun.connect(_update_sun)
	_update_sun(0)

func _update_sun(val: int = 0) -> void:
	sun += val
	sun_label.text = "Sun: %d" % sun
