extends Sprite2D

@export var projectile_resource: Projectiles

var hasHit: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if hasHit:
		set_physics_process(false)
		return
	
	global_position.x = move_toward(global_position.x, 1500, delta * projectile_resource.speed)
