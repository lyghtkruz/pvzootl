extends Node

@export var spin_length: float = 2.0
@onready var item

var tween: Tween
var isSpinning: bool = false

func _ready() -> void:
	item = get_parent()
	tween = get_tree().create_tween()
	tween.tween_property(item, "rotation", deg_to_rad(360), spin_length).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(_reset_rotation)
	tween.set_loops()

func _reset_rotation() -> void:
	item.rotation = deg_to_rad(0.0)

func _spin() -> void:
	if isSpinning:
		return
	
	isSpinning = true
	tween.play()

func _stop() -> void:
	if not isSpinning: 
		return
	
	isSpinning = false
	tween.stop()

func _physics_process(_delta: float) -> void:
	if not isSpinning:
		_spin()
