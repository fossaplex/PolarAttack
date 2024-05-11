class_name Player
extends CharacterBase

const Modifiers = preload("res://Constants/Modifiers.gd")

@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var finite_state_machine := $SingleFiniteStateMachine as SingleFiniteStateMachine
@onready var hit_box := $HitBox as CharacterHitbox
@onready var player_xp_handler:= $PlayerXpHandler as PlayerXpHandler

@onready var death_state := $SingleFiniteStateMachine/DeathState as PlayerDeathState
@onready var idle_state := $SingleFiniteStateMachine/IdleState as PlayerIdleState
@onready var walk_state := $SingleFiniteStateMachine/WalkState as PlayerWalkState

@onready var weapon_handler := $WeaponHandler as WeaponHandler
@onready var modifiers := $Modifiers
@onready var is_beam_active := false
@onready var i_frame: IFrame = $IFrame

@onready var health_progress_bar: ProgressBar = $ProgressBars/HealthProgressBar
@onready var i_frame_progress_bar: ProgressBar = $ProgressBars/IFrameProgressBar

#region lifecycle
func _ready() -> void:
	super()
	fsm = finite_state_machine
	hit_box.character = self
	i_frame.character = self
	fsm.transition(idle_state)
	on_health_change.connect(_on_health_change)

func _process(_delta: float) -> void:
	var timer_left := i_frame.i_frame_cd_timer.time_left
	var wait_time :=  i_frame.i_frame_cd_timer.wait_time
	i_frame_progress_bar.value = (timer_left / wait_time) * i_frame_progress_bar.max_value
#endregion


#region setter getter
func _base_total_health(value: int) -> void:
	super(value)
	if health_progress_bar: health_progress_bar.max_value = value

func _set_health(value: float) -> void:
	if not i_frame.can_take_damage: return
	super(value)
	if health_progress_bar:
		var tween := create_tween()
		tween.tween_property(self, "health_progress_bar:value", health, 0.25)

func _set_speed(value: int) -> void:
	super(value)
	if !is_node_ready(): return
	walk_state.speed = speed
#endregion

func on_beam_active(is_active: bool,  horizontal_direction: float) -> void:
	is_beam_active = is_active
	if (is_beam_active):
		speed_multiplier = 0.2
		sprite.flip_h = horizontal_direction < 0
	else:
		speed_multiplier = 1

func _on_health_change(_health: int, prev_health: int) -> void:
	i_frame.is_invincible = _health <= prev_health

	if _health <= 0:
		var concreate_fsm := fsm as FiniteStateMachine
		concreate_fsm.transition(death_state)
	if _health == prev_health: return
	var tween := create_tween()
	if _health < prev_health:
		tween.tween_property(self, "health_progress_bar:modulate", Color(1,0,0), 1)
	elif _health > prev_health:
		tween.tween_property(self, "health_progress_bar:modulate", Color(0,1,0), 1)
	tween.tween_property(self, "health_progress_bar:modulate", Color(1,1,1), 1)

func add_modifier(modifier: Modifier) -> void:
	if modifier is PlayerModifier:
		modifier.add_dependecies(self)
		modifiers.add_child(modifier)
	elif modifier is WeaponModifier:
		weapon_handler.add_modifier(modifier)
	elif modifier is OrbsModifier:
		weapon_handler.add_modifier(modifier)
