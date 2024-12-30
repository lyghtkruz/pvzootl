extends Sprite2D

@export var zombie_resource: Zombies
@onready var isDead: bool = false

@onready var hitbox: Area2D = $hitbox
@onready var current_hp: int = 0

var hasShader: bool = false

func _ready() -> void:
	current_hp = zombie_resource.hit_points
	
	if not material is ShaderMaterial:
		return
	hasShader = true
	
func hit(damage: int) -> void:
	current_hp -= damage
	
	_flash()
	
	if current_hp < 1:
		isDead = true

func _flash() -> void:
	if not hasShader:
		return
	
	var flash_tween: Tween = get_tree().create_tween()
	flash_tween.tween_property(material, "shader_parameter/flash_amount", 1.0, 0.1)
	flash_tween.tween_property(material, "shader_parameter/flash_amount", 0.0, 0.1)
	flash_tween.play()

func _physics_process(_delta: float) -> void:
	pass
