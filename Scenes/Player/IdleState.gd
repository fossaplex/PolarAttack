extends State

@export var animationPlayer: AnimationPlayer
@export var sprite: Sprite2D
@export var walk_state: State

func enter() -> void:
	animationPlayer.play("idle")

func process_physics(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		request_transition_to.emit(self, walk_state)
