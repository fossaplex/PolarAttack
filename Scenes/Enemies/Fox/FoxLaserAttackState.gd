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

@onready var duration_bar: TextureProgressBar = $"../../Duration"
@onready var cooldown_bar: TextureProgressBar = $"../../Cooldown"


func enter() -> void:
	super()
	animated_sprite_2d.play("beam")
	if duration_timer.paused:
		duration_timer.paused = false
		beam.active = true
		print("unpaused")
		return
	if cool_down_timer.is_stopped():
		duration_timer.start()
		beam.active = true
		return

func _ready() -> void:
	duration_timer.timeout.connect(on_duration_timer_timerout)
	cool_down_timer.timeout.connect(on_cool_down_timer_timerout)

func exit() -> void:
	super()
	beam.active = false
	if not duration_timer.is_stopped():
		duration_timer.paused = true

func _process(_delta: float) -> void:
	duration_bar.value = duration_timer.time_left
	duration_bar.max_value = max_duration
	cooldown_bar.value = cool_down_timer.time_left
	cooldown_bar.max_value = cooldown

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

func on_duration_timer_timerout() -> void:
	cool_down_timer.start()
	beam.active = false
	
func on_cool_down_timer_timerout() -> void:
	if fox.single_finite_state_machine._current_state != self: return
	duration_timer.start()
	beam.active = true
