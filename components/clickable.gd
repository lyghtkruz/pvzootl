class_name Clickable
extends Node

@onready var item: Node # parent's parent node
@onready var item_has_click: bool = false # item has method _mouse_click
@onready var item_has_hover: bool = false # item has method _mouse_enter

@onready var item_has_focus: bool = false # is mouse hovering over parent

func _ready() -> void:
	var parent: Node = get_parent()
	item = parent.get_parent()
	
	if item.has_method("_mouse_click"):
		item_has_click = true
	
	if item.has_method("_mouse_enter"):
		item_has_hover = true
	
	# TODO: add error checking for adding to the wrong item type
	parent.mouse_entered.connect(_on_mouse_enter)
	parent.mouse_exited.connect(_on_mouse_exit)

func _on_mouse_enter() -> void:
	item_has_focus = true
	
	if item_has_hover:
		item._mouse_enter()

func _on_mouse_exit() -> void:
	item_has_focus = false
	
	if item_has_hover:
		item._mouse_exit()

func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("click"):
		return
	
	if not item_has_focus:
		return
	
	if not item_has_click:
		return
	
	get_viewport().set_input_as_handled()
	item._mouse_click()
