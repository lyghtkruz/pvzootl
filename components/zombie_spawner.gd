extends Node

@export var wave_resource: ZombieWaves

@onready var spawn_timer: Timer

var wave_level: Array[ZombieWaveEntry]

const ROW_H: int = 150
const OFFSET: int = 190

func _ready() -> void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.one_shot = false
	spawn_timer.wait_time = 10.0
	spawn_timer.timeout.connect(_spawn)
	
	for wave in wave_resource.wave:
		wave_level.append(wave)
	spawn_timer.start()

func _spawn() -> void:
	if not wave_level.size():
		spawn_timer.stop()
		return
	
	spawn_timer.wait_time = randf_range(15.0, 20.0)
	var random_zombie: int = randi_range(1, wave_level.size()) -1
	var zombie: Node = wave_level[random_zombie].zombie_type.instantiate()
	add_child(zombie)
	zombie.global_position.x = 1920
	zombie.global_position.y = randi_range(1, 5) * ROW_H + OFFSET
	zombie.z_index = zombie.global_position.y
	wave_level[random_zombie].amount -= 1
	if wave_level[random_zombie].amount == 0:
		wave_level.remove_at(random_zombie) 
