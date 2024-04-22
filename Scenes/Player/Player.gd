class_name Player
extends CharacterBase

@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var finite_state_machine := $SingleFiniteStateMachine as SingleFiniteStateMachine
@onready var hit_box := $HitBox as CharacterHitbox

@onready var death_state := $SingleFiniteStateMachine/DeathState as PlayerDeathState
@onready var idle_state := $SingleFiniteStateMachine/IdleState as PlayerIdleState
@onready var walk_state := $SingleFiniteStateMachine/WalkState as PlayerWalkState

@onready var weapons: Node2D = $WeaponHandler/Weapons

@onready var progress_bar := $ProgressBar as ProgressBar

@onready var weapon_handler := $WeaponHandler as WeaponHandler

#region lifecycle
func _ready() -> void:
	super()
	fsm = finite_state_machine
	hit_box.character = self
	fsm.transition(idle_state)
#endregion

#region setter getter
func _set_total_health(value: int) -> void:
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

func on_beam_active(is_active: bool,  horizontal_direction: int) -> void:
	if (is_active):
		speed_multiplier = 0.2
		sprite.flip_h = horizontal_direction < 0
	else:
		speed_multiplier = 1
