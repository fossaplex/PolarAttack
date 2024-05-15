extends State

@onready var fox: Fox = $"../.."
@onready var death_sound: AudioStreamPlayer2D = $"../../DeathSound"

func enter() -> void:
	super()
	death_sound.play()
	await death_sound.finished
	fox.character_queue_free()
