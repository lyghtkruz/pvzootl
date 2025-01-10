class_name AutoClick
extends Node

@export var item_res: ClickableItem
@export var signal_reader: Node

@onready var isClickable: bool = true

func _ready() -> void:
	
	if not signal_reader.has_signal("mouse_entered"):
		push_error("AutoClick: Invalid node parent. Missing: mouse_entered signal")
		return
		
	signal_reader.mouse_entered.connect(_click)

func _click() -> void:
	if not isClickable:
		return
	
	isClickable = false
	if Game.has_signal(item_res.call_signal):
		Game.emit_signal(item_res.call_signal, item_res.value)
	else:
		Log.error("Missing signal: ", item_res.call_signal)
	
	get_parent().visible = false
	get_parent().queue_free()
