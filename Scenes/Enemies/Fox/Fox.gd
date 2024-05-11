class_name Fox
extends CharacterBase

const GROUPS = preload("res://Constants/Groups.gd")

@onready var hit_box: CharacterHitbox = $HitBox
@onready var sleep_area: Area2D = $SleepArea2D

@onready var single_finite_state_machine: SingleFiniteStateMachine = $SingleFiniteStateMachine
@onready var fox_wake_state: State = $SingleFiniteStateMachine/FoxWakeState
@onready var fox_sleep_state: State = $SingleFiniteStateMachine/FoxSleepState
@onready var fox_idle_state: State = $SingleFiniteStateMachine/FoxIdleState
@onready var fox_chase_state: State = $SingleFiniteStateMachine/FoxChaseState
@onready var texture_progress_bar: TextureProgressBar = $ProgressBar
@onready var fox_death_state: State = $SingleFiniteStateMachine/FoxDeathState
@export var target: CharacterBase:
	set(value):
		target = value
		if not is_node_ready(): return
		if target:
			single_finite_state_machine.transition(fox_chase_state)
		else:
			single_finite_state_machine.transition(fox_idle_state)
@onready var attackable: Attackable = $WeaponHandler/WeaponsNode2D/Beam/Attackable
var setup_done := false

const SMALL_EXPERIENCE := preload("res://Scenes/Resources/collectable/CollectableResources/smallExperience.tres")
const GOLD_XP_ANIMATION := preload("res://Graphics/coins/Gold_Xp_Animation.tres")
const SILVER_XP_ANIMATION := preload("res://Graphics/coins/Silver_Xp_Animation.tres")

signal on_death(seal_location: Vector2, xp_resource: ExperienceResource)

func _ready() -> void:
	super()
	hit_box.character = self
	sleep_area.area_entered.connect(on_area_entered)
	on_health_change.connect(_on_health_change)
	on_total_health_change.connect(_on_total_health_change)
	texture_progress_bar.max_value = total_health
	texture_progress_bar.value = health
	single_finite_state_machine.transition(fox_sleep_state)

func on_area_entered(area: Area2D) -> void:
	if not area.is_in_group(GROUPS.PLAYER_HITBOX): return
	if not (area is CharacterHitbox) : return
	if single_finite_state_machine._current_state == fox_sleep_state:
		single_finite_state_machine.transition(fox_wake_state)
		await fox_idle_state.on_enter
		target = (area as CharacterHitbox).character
	else:
		target = (area as CharacterHitbox).character

func _on_health_change(_health: float, _prev_health: float) -> void:
	texture_progress_bar.value = _health
	if _health <= 0:
		single_finite_state_machine.transition(fox_death_state)
		SMALL_EXPERIENCE.collectable_texture = GOLD_XP_ANIMATION
		SMALL_EXPERIENCE.collectable_type = "experience"
		SMALL_EXPERIENCE.experienceValue = 20
		on_death.emit(global_position, SMALL_EXPERIENCE)

func _on_total_health_change(_total_health: float, _prev_total_health: float) -> void:
	texture_progress_bar.max_value = _total_health
