class_name FoxChaseState
extends State

@onready var fox: Fox = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var target: CharacterBase = fox.target:
	get: return fox.target
var speed := 150
@onready var fox_laser_attack_state: Node = $"../FoxLaserAttackState"

func enter() -> void:
	super()
	animated_sprite_2d.play("run")

func exit() -> void:
	super()
	animated_sprite_2d.stop()
	fox.velocity = Vector2.ZERO

func process_frame(delta: float) -> void:
	super(delta)
	if fox.velocity.x != 0:
		animated_sprite_2d.flip_h = fox.velocity.x > 0
	if target.global_position.distance_to(fox.global_position) < 100.0:
		fsm.transition(fox_laser_attack_state)

func process_physics(delta: float) -> void:
	super(delta)
	var direction := (target.global_position - fox.global_position).normalized()
	fox.velocity = direction * speed
	fox.move_and_slide()
