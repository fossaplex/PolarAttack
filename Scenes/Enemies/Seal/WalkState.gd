class_name SealWlakState
extends State

@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var seal: Character

var target: Character
var speed: int = 100

func enter() -> void:
	animation_player.play("walk")

func exit() -> void:
	animation_player.stop()
	seal.velocity = Vector2.ZERO

func process_frame(delta: float) -> void:
	var direction_normalize = seal.velocity.normalized()
	if seal.velocity.x != 0:
		sprite.flip_h = seal.velocity.x > 0


func process_physics(delta: float) -> void:
	var direction := (target.global_position - seal.global_position).normalized()
	var target_distance := seal.global_position.distance_to(target.global_position)

	if target_distance < 20:
		request_transition_to.emit(self, $"../AttackState")
		return
	
	seal.velocity = direction * speed if target_distance > 20 else Vector2.ZERO
	seal.move_and_slide()
