extends Sprite2D

@export var isPlanted: bool = false
@export var plant_resource: Plants
@export var projectile: PackedScene

@onready var detector: RayCast2D = $detector
@onready var dance: Node = $Dance
@onready var spawn: Marker2D = $spawn
@onready var attack_timer: Timer = $attack_timer

var isFollowingMouse: bool = false

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

func _ephemeral() -> void:
	set_process(true)
	isZombieNear = false
	set_physics_process(false)
	dance.stop()
	modulate = Color(1.0, 1.0, 1.0, 0.5)
	isFollowingMouse = true

func _ready() -> void:
	set_process(false)
	_setup_attack()
	Game.snap.connect(_snap_to_plot)
	if isPlanted:
		detector.global_position = global_position
		return
	_ephemeral()

func _setup_attack() -> void:
	attack_timer.autostart = false
	attack_timer.one_shot = false
	attack_timer.wait_time = plant_resource.attack_speed
	attack_timer.timeout.connect(_attack)

func _attack() -> void:
	var new_projectile = projectile.instantiate()
	Game.projectiles_area.add_child(new_projectile)
	new_projectile.global_position = spawn.global_position

func _snap_to_plot(pos: Vector2) -> void:
	if isPlanted:
		return
	isFollowingMouse = false
	global_position = pos

func plant() -> void:
	Game.isPlanting = false
	Game.plantingScene = null
	detector.global_position = global_position
	isPlanted = true
	isZombieNear = true
	set_physics_process(true)
	modulate = Color(1.0, 1.0, 1.0, 1.0)
	isFollowingMouse = false
	Game.sun.emit(-plant_resource.sun_cost)

func _physics_process(_delta: float) -> void:
	if detector.is_colliding():
		isZombieNear = true
	else:
		isZombieNear = false

func _process(_delta: float) -> void:
	if isPlanted:
		return
	
	if not isFollowingMouse:
		set_process(false)
		return
	
	global_position = get_global_mouse_position()
