extends CharacterBody2D

@export var SPEED = 300.0

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

func _process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

	var horizontal_direction = Input.get_axis("move_left", "move_right")
	flip_sprite(horizontal_direction)

	move_and_slide()
	update_animation(direction)

func flip_sprite(horizontal_direction: float):
		if horizontal_direction != 0: sprite.flip_h = horizontal_direction == 1

func update_animation(direction: Vector2):
	if direction == Vector2.ZERO:
		ap.play("idle")
	else:
		ap.play("walk")
