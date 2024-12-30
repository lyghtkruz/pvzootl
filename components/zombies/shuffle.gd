extends Node

var zombie
var shuffle_speed

func _ready() -> void:
	zombie = get_parent()
	shuffle_speed = zombie.zombie_resource.speed

func _physics_process(delta: float) -> void:
	if zombie.isDead:
		set_physics_process(false)
		return
	
	zombie.global_position.x = move_toward(zombie.global_position.x, 0, delta * shuffle_speed)
