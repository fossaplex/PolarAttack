class_name SealAttackState
extends State

var animation_player: AnimationPlayer
var seal: Character
var target: Character

func enter() -> void:
	animation_player.stop()

func process_frame(delta: float) -> void:
	var target_distance := seal.global_position.distance_to(target.global_position)

	if target_distance >= 0:
		request_transition_to.emit(self, $"../WalkState")
		return

	seal.velocity = Vector2.ZERO
	seal.move_and_slide()
