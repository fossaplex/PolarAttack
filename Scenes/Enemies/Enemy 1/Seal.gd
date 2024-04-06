extends CharacterBody2D

const SPEED = 100.0

var PLAYER

func _ready():
	PLAYER = get_node('/root/Level/Player')

func _physics_process(delta):
	#var direction = global_position.direction_to(PLAYER.global_position)
	#var velocity = direction * SPEED 
	position += (PLAYER.position - position)/SPEED
	move_and_slide()
