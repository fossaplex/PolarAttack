extends State

@export var animation_player: AnimationPlayer
@export var spirte: Sprite2D
@export var seal: Character
@onready var death_sound := $DeathSound as AudioStreamPlayer

func enter() -> void:
	animation_player.stop()
	death_sound.play()

func process_frame(delta: float) -> void:
	seal.velocity = Vector2.ZERO
	if death_sound.playing: return
	seal.modify_queue_free()
	
