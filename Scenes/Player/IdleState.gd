class_name PlayerIdleState
extends State

@onready var animation_player := $"../../AnimationPlayer"
@onready var walk_state := $"../WalkState"

func enter() -> void:
	animation_player.play("idle")

func process_physics(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		fsm.transition(walk_state)
