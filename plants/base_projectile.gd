extends Sprite2D

@export var projectile_resource: Projectiles
@onready var hurtbox: Area2D = $hurtbox

var hasHit: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurtbox.area_entered.connect(_hit)

func _hit(hitbox: Area2D) -> void:
	if hasHit: 
		return
	
	var zombie = hitbox.get_parent()
	if zombie.has_method("hit"):
		zombie.hit(projectile_resource.damage)
		hasHit = true
		visible = false
		queue_free()

func _physics_process(delta: float) -> void:
	if hasHit:
		set_physics_process(false)
		return
	
	global_position.x = move_toward(global_position.x, 1500, delta * projectile_resource.speed)
