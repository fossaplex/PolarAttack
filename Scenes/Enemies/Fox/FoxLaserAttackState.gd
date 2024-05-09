extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var fox: Fox = $"../.."
@onready var target: CharacterBase = fox.target:
	get: return fox.target
@onready var fox_chase_state: Node = $"../FoxChaseState"
@onready var beam: Beam = $"../../WeaponHandler/WeaponsNode2D/Beam"
@onready var laser_marker_left: Marker2D = $"../../WeaponHandler/Node2D/LaserMarkerLeft"
@onready var laser_marker_right: Marker2D = $"../../WeaponHandler/Node2D/LaserMarkerRight"

@onready var cool_down_timer: Timer = $CoolDownTimer
@onready var duration_timer: Timer = $DurationTimer

@export var max_duration := 3.0
@export var cooldown := 3.0

func enter() -> void:
	super()
	animated_sprite_2d.play("beam")
	if cool_down_timer.is_stopped():
		duration_timer.start()
		beam.active = true

func _ready() -> void:
	duration_timer.timeout.connect(on_duration_timer_timerout)
	cool_down_timer.timeout.connect(on_cool_down_timer_timerout)

func exit() -> void:
	super()
	beam.active = false

func process_frame(delta: float) -> void:
	super(delta)
	var direction := fox.global_position.direction_to(target.global_position)

	animated_sprite_2d.flip_h = direction.x > 0

	if animated_sprite_2d.flip_h:
		beam.global_position = laser_marker_right.global_position
	else:
		beam.global_position = laser_marker_left.global_position

	if target.global_position.distance_to(fox.global_position) >= 150.0:
		fsm.transition(fox_chase_state)
		cool_down_timer.stop()

func on_duration_timer_timerout() -> void:
	cool_down_timer.start()
	beam.active = false
	
func on_cool_down_timer_timerout() -> void:
	duration_timer.start()
	beam.active = true
