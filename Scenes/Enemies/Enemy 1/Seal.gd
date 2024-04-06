extends CharacterBody2D

@export var SPEED = 20.0

@onready var target: CharacterBody2D = get_node('/root/Level/Player')

func _physics_process(delta):
	var direction = (target.global_position - global_position)
	var direction_normalize = direction.normalized()
	var target_distance = global_position.distance_to(target.global_position)
	velocity = direction_normalize * SPEED if target_distance > 10 else Vector2.ZERO
	move_and_slide()
