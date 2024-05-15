class_name PlayerDeathState
extends State

@onready var animation_player := $"../../AnimationPlayer" as AnimationPlayer
@onready var sprite := $"../../Sprite2D" as Sprite2D
@onready var player := $"../.." as Player


signal is_dead

func enter() -> void:
	super()
	animation_player.play("death")
	is_dead.emit()

func process_physics(delta: float) -> void:
	super(delta)
	player.velocity = Vector2.ZERO
	player.move_and_slide()
