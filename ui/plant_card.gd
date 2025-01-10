extends Control

# TODO: Make this either custom resource or class to 
# make it easy to build new 
@export var plant_scene: PackedScene
@export var plant_resource: Plants

@onready var card_backing: TextureRect = $card_backing
@onready var plant: TextureRect = $plant
@onready var plant_shadow: TextureRect = $plant_shadow
@onready var plant_cost_label: Label = $plant_cost_label
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var isWaiting: bool = false

@onready var plant_cost: int = 100

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
	
	card_backing.texture = plant_resource.card_back
	plant.texture = plant_resource.card_image
	plant_shadow.texture = plant_resource.card_image
	plant_cost_label.text = str(plant_resource.sun_cost)
	plant_cost = plant_resource.sun_cost
	progress_bar.value = 0
	Game.planted.connect(_on_planted)

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

func _on_planted() -> void:
	if not isWaiting:
		return
	progress_bar.value = 100
	var tween = create_tween()
	tween.tween_property(progress_bar, "value", 0.0, plant_resource.recharge_rate)
	tween.tween_callback(func(): isWaiting = false)

func _input(event: InputEvent) -> void:
	if isWaiting:
		return
	
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
	isWaiting = true

func update_availability(sun: int) -> void:
	if plant_cost > sun:
		canAfford = false
		return
	canAfford = true
