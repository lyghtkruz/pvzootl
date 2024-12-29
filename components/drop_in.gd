extends Node

@export var drop_speed: float = 100.0

@onready var item
@onready var target: Vector2

func _ready() -> void:
	item = get_parent()
	# TODO: Spawn on grid for target position 
	item.global_position = Vector2(randi_range(80, 1200), 5.0)
	target.y = randi_range(400, 780)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if item.global_position.y >= target.y:
		set_physics_process(false)
		return
	
	item.global_position.y = move_toward(item.global_position.y, target.y, delta * drop_speed)
