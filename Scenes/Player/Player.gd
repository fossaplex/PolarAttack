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

@onready var progress_bar := $ProgressBar as ProgressBar
 
@onready var weapon_handler := $WeaponHandler as WeaponHandler
@onready var modifiers := $Modifiers
@onready var is_beam_active := false

#region lifecycle
func _ready() -> void:
	super()
	fsm = finite_state_machine
	hit_box.character = self
	fsm.transition(idle_state)
#endregion

#region setter getter
func _base_total_health(value: int) -> void:
	super(value)
	if progress_bar: progress_bar.max_value = value

func _set_health(value: int) -> void:
	super(value)
	if progress_bar: progress_bar.value = value
	if health <= 0:
		var concreate_fsm := fsm as FiniteStateMachine
		concreate_fsm.transition(death_state)

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

func add_modifier(modifier: Modifier) -> void:
	if modifier is PlayerModifier:
		modifier.add_dependecies(self)
		modifiers.add_child(modifier)
	elif modifier is WeaponModifier:
		weapon_handler.add_modifier(modifier)
	elif modifier is OrbsModifier:
		weapon_handler.add_modifier(modifier)

func get_player_level() -> int:
	return player_xp_handler.current_level
