extends Sprite2D

@export var item_res: ClickableItem

@onready var click_area: Area2D = $click_area
@onready var click_shape: CollisionShape2D = $click_area/click_shape

var has_focus: bool = false
var is_clickable: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	click_area.mouse_entered.connect(_on_mouse_over)
	click_area.mouse_exited.connect(_on_mouse_exit)

func _on_mouse_over() -> void:
	has_focus = true

func _on_mouse_exit() -> void:
	has_focus = false

func _input(event: InputEvent) -> void:
	if not has_focus:
		return
	
	if not event.is_action_pressed("click"):
		return
	
	_click()

func _click() -> void:
	if not is_clickable:
		return
	
	is_clickable = false
	if Game.has_signal(item_res.call_signal):
		Game.emit_signal(item_res.call_signal, item_res.value)
	else:
		Log.error("Missing signal: ", item_res.call_signal)
	
	visible = false
	queue_free()
