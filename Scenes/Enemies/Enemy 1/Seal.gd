class_name Seal
extends CharacterBase
const SEAL_SCENE = preload("res://Scenes/Enemies/Enemy 1/Seal.tscn")

const SMALL_EXPERIENCE := preload("res://Scenes/Resources/collectable/CollectableResources/smallExperience.tres")
const GOLD_XP_ANIMATION := preload("res://Graphics/coins/Gold_Xp_Animation.tres")
const SILVER_XP_ANIMATION := preload("res://Graphics/coins/Silver_Xp_Animation.tres")
@onready var damage_number: DamageNumber = $DamageNumber

#region Members
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var sprite := $Sprite2D as Sprite2D
@onready var walk_state := $FiniteStateMachine/WalkState as State
@onready var wander_state := $FiniteStateMachine/WanderState as State
@onready var finite_state_machine := $FiniteStateMachine as SingleFiniteStateMachine
@onready var death_state := $FiniteStateMachine/DeathState as SealDeathState
@onready var texture_progress_bar := $TextureProgressBar as TextureProgressBar
@onready var hit_box := $HitBox as CharacterHitbox
@onready var attackable: Attackable = $Attackable as Attackable
@export var _attackable_resource : AttackableResource = AttackableResource.new():
	set(value):
		if !is_node_ready(): return
		attackable.base_damage = value.base_damage
		attackable.multiplier = value.multiplier

@onready var target: CharacterBase = null:
	set(value):
		target = value
		if !is_node_ready(): return
		if !finite_state_machine or !finite_state_machine.has_current_state(): return
		if target:
			finite_state_machine.transition(walk_state)
		else:
			finite_state_machine.transition(wander_state)
#endregion

@export var base_damage: float = 10
@export var damage_multiplier := 1
var damage: float = base_damage * damage_multiplier:
	get: return base_damage * damage_multiplier

#region Signals
signal on_death(sealLocation: Vector2, xpResource: ExperienceResource)
#endregion

#region Override
func _ready() -> void:
	super()
	target = target
	_attackable_resource = _attackable_resource
	fsm = finite_state_machine
	hit_box.character = self
	attackable.damage = damage
	on_health_change.connect(_on_health_change)
	fsm.transition(walk_state if target else wander_state)

func _set_health(value: float) -> void:
	super(value)
	texture_progress_bar.value = value
	texture_progress_bar.max_value = total_health
	if (fsm and value <= 0):
		if fsm.transition(death_state):
			SMALL_EXPERIENCE.collectable_texture = SILVER_XP_ANIMATION
			SMALL_EXPERIENCE.collectable_type = "experience"
			SMALL_EXPERIENCE.experienceValue = 20
			on_death.emit(global_position, SMALL_EXPERIENCE)
#endregion

func flip_sprite(horizontal_direction: float) -> void:
		if horizontal_direction != 0: sprite.flip_h = horizontal_direction == 1

func update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		ap.stop()
	else:
		ap.play("walk")

func _on_health_change(_health: float, prev_health: float) -> void:
	if _health < prev_health:
		damage_number.display_number(ceil(prev_health - _health))
		sprite.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.05).timeout
		sprite.modulate = Color(3, 3, 3, 1)
		await get_tree().create_timer(0.05).timeout
		sprite.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.05).timeout
		sprite.modulate = Color(3, 3, 3, 1)
		await get_tree().create_timer(0.05).timeout
		sprite.modulate = Color(1,1,1,1)

