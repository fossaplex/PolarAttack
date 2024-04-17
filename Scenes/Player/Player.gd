class_name Player
extends CharacterBase

@onready var sprite := $Sprite2D as Sprite2D
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var finite_state_machine := $SingleFiniteStateMachine as SingleFiniteStateMachine
@onready var hit_box := $HitBox as CharacterHitbox

@onready var death_state := $SingleFiniteStateMachine/DeathState as PlayerDeathState
@onready var idle_state := $SingleFiniteStateMachine/IdleState as PlayerIdleState
@onready var walk_state := $SingleFiniteStateMachine/WalkState as PlayerWalkState

@onready var projectiles = $Projectiles
@onready var orbs := $Projectiles/Orbs as Orbs
@onready var beam := $Projectiles/Beam as Beam
@onready var progress_bar := $ProgressBar as ProgressBar

#region Orb damamge
@export var base_orb_damage := 10
@export var orb_damage_multiplier := 1
var orb_damage: float = 10:
	get: return base_orb_damage * orb_damage_multiplier
#endregion

#region beam damage
@export var base_beam_damage: float = 10
@export var beam_damage_multiplier := 1
var beam_damage: float = 10:
	get: return base_beam_damage * beam_damage_multiplier
#endregion

func _ready():
	super()
	on_dead.connect(_on_dead)
	fsm = finite_state_machine
	beam.visible = false
	hit_box.character = self
	fsm.transition(idle_state)
	
func _process(delta):
	super(delta)
	if !beam or !orbs: return
	beam.attackable.damage = beam_damage
	orbs.damage = orb_damage

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
func _on_dead(prev_health: int) -> void:
	projectiles.queue_free()
