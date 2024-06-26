class_name SealDeathState
extends State

@onready var animation_player := $"../../AnimationPlayer" as AnimationPlayer
@onready var seal := $"../.." as Seal
@onready var death_sound := $"../../DeathSound" as AudioStreamPlayer2D

func enter() -> void:
	super()
	animation_player.stop()
	death_sound.play()

func process_frame(delta: float) -> void:
	super(delta)
	seal.velocity = Vector2.ZERO
	if death_sound.playing: return
	seal.character_queue_free()
	
