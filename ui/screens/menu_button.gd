extends Control

@export var button_signal: String
@export var button_sound: AudioStreamOggVorbis
@export var button_texture: Texture2D

@onready var button: TextureRect = $button
@onready var button_audio_player: AudioStreamPlayer = $button_audio_player
@onready var button_parent: Node
@onready var button_shadow: TextureRect = $button_shadow
@onready var button_shape: ColorRect = $button_shape
@onready var button_offset: Vector2 = Vector2(6, 6)

func _ready() -> void:
	button.texture = button_texture
	button_shadow.texture = button_texture
	button_audio_player.stream = button_sound
	var shape_data: Rect2 = lyght.get_visible_rect(button_texture)
	button_shape.global_position = shape_data.position
	button_shape.size = shape_data.size
	button_parent = get_parent()

func _mouse_click() -> void:
	button_parent.emit_signal(button_signal)

func _mouse_enter() -> void:
	button_audio_player.play()
	button.global_position += button_offset

func _mouse_exit() -> void:
	button.global_position -= button_offset
