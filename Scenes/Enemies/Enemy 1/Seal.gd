extends CharacterBody2D

const SPEED = 100.0

@onready var player = get_node('/root/Level/Player')
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Seal

func _process(delta: float):
	var direction_normalize = velocity.normalized()
	if velocity.x != 0:
		sprite.flip_h = velocity.x > 0
	update_animation(velocity.normalized())
	
	
func _physics_process(delta: float):
	var direction = (player.global_position - global_position)
	var direction_normalize = direction.normalized()
	var target_distance = global_position.distance_to(player.global_position)

	velocity = direction_normalize * SPEED if target_distance > 20 else Vector2.ZERO
	move_and_slide()

func flip_sprite(horizontal_direction: float):
		if horizontal_direction != 0: sprite.flip_h = horizontal_direction == 1

func update_animation(direction: Vector2):
	if direction == Vector2.ZERO:
		ap.stop()
	else:
		ap.play("walk")
