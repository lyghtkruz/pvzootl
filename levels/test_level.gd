extends Node2D

@onready var plants: Node2D = $plants
@onready var projectiles: Node2D = $projectiles

func _ready() -> void:
	Game.plant_area = plants
	Game.projectiles_area = projectiles
