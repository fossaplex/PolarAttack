extends State

@onready var fox: Fox = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var target: CharacterBase = fox.target:
	get: return fox.target
var speed := 200
@onready var fox_laser_attack_state: Node = $"../FoxLaserAttackState"
@onready var sound_walk: AudioStreamPlayer2D = $"../../SoundWalk"

func enter() -> void:
	super()
	animated_sprite_2d.play("run")
	sound_walk.play()
	sound_walk.finished.connect(
		func() -> void:
			if (fsm as SingleFiniteStateMachine)._current_state == self:
				sound_walk.play()
	)

func exit() -> void:
	super()
	animated_sprite_2d.stop()
	sound_walk.stop()
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
