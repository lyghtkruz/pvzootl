extends CanvasLayer

@onready var bar: GridContainer = $bar
@onready var sun_label: Label = $bar/sun_label

var sun: int = 0

func _ready() -> void:
	Game.sun.connect(_update_sun)
	_update_sun(100)

func _update_sun(val: int = 0) -> void:
	sun += val
	sun_label.text = "Sun\n%d" % sun
	hud_refresh()

func hud_refresh() -> void:
	for item in bar.get_children():
		if item.has_method("update_availability"):
			item.update_availability(sun)
