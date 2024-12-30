extends Sprite2D

@export var plant_resource: Plants
@export var projectile: PackedScene

@onready var detector: RayCast2D = $detector
@onready var dance: Node = $Dance
@onready var spawn: Marker2D = $spawn
@onready var attack_timer: Timer = $attack_timer

# Defaulting to true, in order to start 
# dancing right away on the first physics loop
var isZombieNear: bool = true:
	set(value):
		if isZombieNear == value:
			return
		
		isZombieNear = value
		if isZombieNear:
			dance.stop()
			attack_timer.start()
		else:
			dance.dance()
			attack_timer.stop()

func _ready() -> void:
	detector.global_position = global_position
	_setup_attack()

func _setup_attack() -> void:
	attack_timer.autostart = false
	attack_timer.one_shot = false
	attack_timer.wait_time = plant_resource.attack_speed
	attack_timer.timeout.connect(_attack)

func _attack() -> void:
	print("attack?")
	var new_projectile = projectile.instantiate()
	add_child(new_projectile)
	new_projectile.global_position = spawn.global_position
	print(new_projectile.name)

func _physics_process(_delta: float) -> void:
	if detector.is_colliding():
		isZombieNear = true
	else:
		isZombieNear = false
