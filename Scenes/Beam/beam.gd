class_name Beam
extends Node2D

const GROUPS = preload("res://Constants/Groups.gd")

const MAX_LENGTH = 2000

@onready var beam := $Beam as Sprite2D
@onready var end := $End as Node2D
@onready var raycast := $RayCast2D as RayCast2D
@onready var attackable := $Attackable as Attackable

func _physics_process(delta: float):
	var mouse_position = get_local_mouse_position()
	var max_cast_to = mouse_position.normalized() * MAX_LENGTH
	raycast.target_position = max_cast_to
	if raycast.is_colliding():
		end.global_position = raycast.get_collision_point()
	else:
		end.global_position = raycast.target_position
	beam.rotation = raycast.target_position.angle()
	beam.region_rect.end.x = end.position.length()

func _process(delta):
	var node := raycast.get_collider()
	if node is CharacterHitbox and node.is_in_group(GROUPS.ENEMY_HITBOX):
		attackable.deal_damange_delta(node.character, delta)
