extends ColorRect

@export var isWater: bool = false

var hasFocus: bool = false
var isAvailable: bool = true
var hasPlant: bool = false
var hasArmor: bool = false

var plantRef
var armorRef

func _ready() -> void:
	mouse_entered.connect(_on_mouse_over)
	mouse_exited.connect(_on_mouse_exit)

func _on_mouse_over() -> void:
	hasFocus = true
	
	var offset: Vector2 = Vector2(size.x/2.0, (size.y/2.0) - 10.0)
	if Game.isPlanting:
		Game.emit_signal("snap", global_position + offset)

func _on_mouse_exit() -> void:
	hasFocus = false

func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("click"):
		return
	
	if not hasFocus:
		return
	
	_click()

func _click() -> void:
	# TODO: Handle digging up conditions
	if not Game.isPlanting:
		return
	
	if not isAvailable:
		return
	
	get_viewport().set_input_as_handled()
	isAvailable = false
	Game.plantingScene.plant()
	Game.emit_signal("planted")
