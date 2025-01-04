extends Node2D

@onready var animation: AnimationPlayer = $animation
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(wave)

func wave() -> void:
	animation.play("wave")
