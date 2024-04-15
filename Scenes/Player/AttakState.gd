extends State

@export var laserBeam: Beam
@export var attackable: Attackable
@export var animationPlayer: AnimationPlayer
@export var sprite: Sprite2D
@export var player: CharacterBody2D

func enter() -> void:
	laserBeam.visible = true
	laserBeam.raycast.collide_with_bodies = true
	laserBeam.raycast.collide_with_areas = true
	animationPlayer.play("idle")

func exit() -> void:
	laserBeam.visible = false
	laserBeam.raycast.collide_with_bodies = false
	laserBeam.raycast.collide_with_areas = false

func process_frame(delta: float) -> void:
	var direction := laserBeam.raycast.target_position.direction_to(player.global_position).normalized()
	sprite.flip_h = direction.x < 0
		
func process_physics(delta: float) -> void:
	var node := laserBeam.raycast.get_collider()
	if node is CharacterHitbox:
		attackable.deal_damange_delta(node.character, delta)
