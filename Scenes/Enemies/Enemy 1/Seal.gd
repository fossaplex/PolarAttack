class_name Seal
extends CharacterBase

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
@onready var attackable := $FiniteStateMachine/WalkState/Attackable as Attackable
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
