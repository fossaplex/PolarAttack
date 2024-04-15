extends State

@export var animation_player: AnimationPlayer
@export var spirte: Sprite2D
@export var seal: Character

func enter() -> void:
	animation_player.stop()
	seal.modify_queue_free()

func process_frame(delta: float) -> void:
	seal.velocity = Vector2.ZERO
