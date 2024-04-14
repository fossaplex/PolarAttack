extends CharacterBody2D

@export var SPEED := 300.0

@onready var ap := $AnimationPlayer as AnimationPlayer
@onready var sprite := $Sprite2D as Sprite2D
@onready var laserMarker := $LaserMarker2D as Marker2D
@onready var laser := $Beam as Node2D

func _ready() -> void:
	laser.visible = false

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED

	var horizontal_direction := Input.get_axis("move_left", "move_right")
	flip_sprite(horizontal_direction)

	if velocity.length() != 0:
		if $Timer.time_left <= 0:
			$SoundWalk.pitch_scale = randf_range(.4,.6)
			$SoundWalk.play()
			$Timer.start(.21)
	move_and_slide()
	update_animation(direction)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("primary_attack") and event.is_pressed():
			laser.visible = true
		else:
			laser.visible = false

func flip_sprite(horizontal_direction: float) -> void:
		if horizontal_direction != 0: sprite.flip_h = horizontal_direction == 1

func update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		ap.play("idle")
	else:
		ap.play("walk")
