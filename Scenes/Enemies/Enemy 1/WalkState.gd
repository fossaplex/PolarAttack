class_name WalkState
extends State

@onready var animation_player := $"../../AnimationPlayer" as AnimationPlayer
@onready var sprite := $"../../Sprite2D" as Sprite2D
@onready var seal := $"../.." as Seal
@onready var target: CharacterBody2D = seal.target:
	get: return seal.target

@export var speed: int = 100

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
	
	seal.velocity = direction * speed
	seal.move_and_slide()
