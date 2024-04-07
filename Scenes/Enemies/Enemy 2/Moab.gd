'''extends CharacterBody2D

const SPEED = 100.0

var PLAYER

func _ready():
	PLAYER = get_node('/root/Level/Player')

func _physics_process(delta):
	#var direction = global_position.direction_to(PLAYER.global_position)
	#var velocity = direction * SPEED 
	position += (PLAYER.position - position)/SPEED
	move_and_slide()
'''
extends CharacterBody2D

const SPEED = 100.0
const AVOIDANCE_FORCE = 50.0
const MAX_SEE_AHEAD = 100.0

var player
var vel = Vector2.ZERO

func _ready():
	player = get_node("/root/Level/Player")

func _physics_process(delta):
	var target_direction = (player.global_position - global_position).normalized()
	var avoidance = Vector2.ZERO
	
	# Simple obstacle avoidance with raycasting
	if $RayCast2D.is_colliding():
		var collision_normal = $RayCast2D.get_collision_normal()
		avoidance = collision_normal * AVOIDANCE_FORCE
	
	# Combining steering behaviors: seek the player and avoid obstacles
	var steering = target_direction * SPEED + avoidance
	vel = steering
	
	# Move the enemy
	move_and_slide()

# Utility function to limit vector length
func limit(vector: Vector2, max_length: float) -> Vector2:
	if vector.length() > max_length:
		return vector.normalized() * max_length
	return vector


