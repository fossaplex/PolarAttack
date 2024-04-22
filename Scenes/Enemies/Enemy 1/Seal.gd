class_name Seal
extends CharacterBase
const SEAL_SCENE = preload("res://Scenes/Enemies/Enemy 1/Seal.tscn")

static func instanciate_seal(
	_target: CharacterBase,
	_base_damage: float,
	_damage_multiplier: float,
	_global_position: Vector2,
	parent: Node,
	_on_death: Callable
) -> Seal:
	var seal := SEAL_SCENE.instantiate() as Seal
	parent.add_child(seal)
	seal.target = _target
	(seal.attackable as Attackable).update(_base_damage, _damage_multiplier)
	seal.global_position = _global_position
	seal.on_death.connect(_on_death)
	seal.base_speed = 50
	return seal

const SMALL_EXPERIENCE = preload("res://Scenes/Resources/collectable/CollectableResources/smallExperience.tres")
const GOLD_XP_ANIMATION = preload("res://Graphics/coins/Gold_Xp_Animation.tres")
const SILVER_XP_ANIMATION = preload("res://Graphics/coins/Silver_Xp_Animation.tres")

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
	fsm.transition(walk_state if target else wander_state)

func _set_total_health(value: int) -> void:
	super(value)
	texture_progress_bar.max_value = value

func _set_health(value: int) -> void:
	super(value)
	texture_progress_bar.value = value
	if (fsm and value <= 0):
		if fsm.transition(death_state):
			SMALL_EXPERIENCE.collectable_texture = GOLD_XP_ANIMATION
			SMALL_EXPERIENCE.collectable_type = "experience"
			SMALL_EXPERIENCE.experienceValue = 20
			on_death.emit(self.global_position, SMALL_EXPERIENCE)
#endregion

func flip_sprite(horizontal_direction: float) -> void:
		if horizontal_direction != 0: sprite.flip_h = horizontal_direction == 1

func update_animation(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		ap.stop()
	else:
		ap.play("walk")
