extends Node

@export var wave_resource: ZombieWaves

@onready var spawn_timer: Timer

var wave_level: Array[ZombieWaveEntry]

func _ready() -> void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.one_shot = false
	spawn_timer.wait_time = 3.0
	spawn_timer.timeout.connect(_spawn)
	
	for wave in wave_resource.wave:
		wave_level.append(wave)
	spawn_timer.start()

func _spawn() -> void:
	if not wave_level.size():
		spawn_timer.stop()
		return
	
	spawn_timer.wait_time = randf_range(1.5, 3.0)
	var random_zombie: int = randi_range(1, wave_level.size()) -1
	var zombie = wave_level[random_zombie].zombie_type.instantiate()
	add_child(zombie)
	zombie.global_position.x = 1060
	zombie.global_position.y = randi_range(1, 5) * 100 + 107
	wave_level[random_zombie].amount -= 1
	if wave_level[random_zombie].amount == 0:
		wave_level.remove_at(random_zombie) 