class_name PlayerAttackState
extends State

@onready var beam := $"../../Projectiles/Beam" as Beam
@onready var animation_player := $"../../AnimationPlayer" as AnimationPlayer
@onready var sprite := $"../../Sprite2D" as Sprite2D
@onready var player := $"../.." as Player

func enter() -> void:
	beam.visible = true
	beam.raycast.collide_with_bodies = true
	beam.raycast.collide_with_areas = true
	animation_player.play("idle")

func exit() -> void:
	beam.visible = false
	beam.raycast.collide_with_bodies = false
	beam.raycast.collide_with_areas = false

func process_frame(delta: float) -> void:
	var direction := beam.raycast.target_position.direction_to(player.global_position).normalized()
	sprite.flip_h = direction.x < 0
		
func process_physics(delta: float) -> void:
	var node := beam.raycast.get_collider()
	if node is CharacterHitbox:
		beam.attackable.deal_damange_delta(node.character, delta)
