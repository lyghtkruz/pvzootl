extends ColorRect

# TODO: Make this either custom resource or class to 
# make it easy to build new 

@onready var card_backing: TextureRect = $card_backing
@onready var plant: TextureRect = $plant

@export var plant_scene: PackedScene 
@export var plant_cost: int = 100

var canAfford: bool = false:
	set(value):
		canAfford = value
		if canAfford:
			plant.modulate = Color(1.0, 1.0, 1.0, 1.0)
			card_backing.modulate = Color(1.0, 1.0, 1.0, 1.0)
		else:
			plant.modulate = Color(1.0, 1.0, 1.0, 0.5)
			card_backing.modulate = Color(1.0, 1.0, 1.0, 0.5)
			
var hasFocus: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	card_backing.mouse_entered.connect(_on_mouse_over)
	card_backing.mouse_exited.connect(_on_mouse_exit)

func _on_mouse_over() -> void:
	hasFocus = true
	
	if Game.isPlanting:
		return
	
	if not canAfford:
		return
	
	card_backing.modulate = Color(1.0, 1.0, 0.784, 1.0)

func _on_mouse_exit() -> void:
	hasFocus = false
	
	if Game.isPlanting:
		return
	
	if not canAfford:
		return
	
	card_backing.modulate = Color(1.0, 1.0, 1.0, 1.0)

func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("click"):
		return
	
	if not canAfford:
		return
	
	if not hasFocus:
		return
		
	_click()

func _click() -> void:
	var new_plant = plant_scene.instantiate()
	Game.plant_area.add_child(new_plant)
	Game.plantingScene = new_plant
	Game.planting.emit()

func update_availability(sun: int) -> void:
	if plant_cost > sun:
		canAfford = false
		return
	canAfford = true
