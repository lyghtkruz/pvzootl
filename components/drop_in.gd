extends Node

@export var drop_speed: float = 100.0

@onready var item
@onready var target: Vector2

const TOP_LEFT: Vector2 = Vector2(525.0, 295.0)
const BOTTOM_RIGHT: Vector2 = Vector2(1825.0, 1005.0)

func _ready() -> void:
	item = get_parent()
	# TODO: Spawn on grid for target position 
	target = lyght.get_random_point(TOP_LEFT, BOTTOM_RIGHT)
	item.global_position.x = int(target.x)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if item.global_position.y >= target.y:
		set_physics_process(false)
		return
	
	item.global_position.y = move_toward(item.global_position.y, target.y, delta * drop_speed)
