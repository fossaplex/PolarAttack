extends CharacterBody2D

@export var SPEED = 300.0

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var laserMarker = $LaserMarker2D
@onready var laser: Node2D = $Beam

func _ready():
	laser.visible = false
	
func _physics_process(delta: float):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

	var horizontal_direction = Input.get_axis("move_left", "move_right")
	flip_sprite(horizontal_direction)

	move_and_slide()
	update_animation(direction)

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("primary_attack") and event.is_pressed():
			laser.visible = true
		else:
			laser.visible = false

func flip_sprite(horizontal_direction: float):
		if horizontal_direction != 0: sprite.flip_h = horizontal_direction == 1

func update_animation(direction: Vector2):
	if direction == Vector2.ZERO:
		ap.play("idle")
	else:
		ap.play("walk")
