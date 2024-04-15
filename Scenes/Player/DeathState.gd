extends State

@export var animationPlayer: AnimationPlayer
@export var sprite: Sprite2D
@export var player: Character

signal is_dead

func enter() -> void:
	animationPlayer.play("death")
	is_dead.emit()

func process_physics(_delta: float) -> void:
	player.velocity = Vector2.ZERO
	player.move_and_slide()
