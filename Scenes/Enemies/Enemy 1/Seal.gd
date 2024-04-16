class_name Seal
extends CharacterBase

#region Members
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var sprite := $Sprite2D as Sprite2D
@onready var walk_state := $FiniteStateMachine/WalkState as State
@onready var wander_state := $FiniteStateMachine/WanderState as State
@onready var finite_state_machine := $FiniteStateMachine as SingleFiniteStateMachine
@onready var death_state := $FiniteStateMachine/DeathState as SealDeathState
@onready var texture_progress_bar := $TextureProgressBar as TextureProgressBar
@onready var hit_box := $HitBox as CharacterHitbox
@onready var target = get_node('/root/Level/Player'):
	set(value):
		target = value
		if !is_node_ready(): return
		if !finite_state_machine or !finite_state_machine.has_current_state(): return
		if target:
			finite_state_machine.transition(walk_state)
		else:
			finite_state_machine.transition(wander_state)
#endregion

#region Signals
signal on_death
#endregion

#region Override
func _ready():
	target = target
	fsm = finite_state_machine
	hit_box.character = self
	fsm.transition(walk_state)

func _set_total_health(value: int) -> void:
	super(value)
	texture_progress_bar.max_value = value

func _set_health(value: int) -> void:
	super(value)
	texture_progress_bar.value = value
	if (fsm and value <= 0):
		if fsm.transition(death_state):
			on_death.emit()
#endregion

func flip_sprite(horizontal_direction: float):
		if horizontal_direction != 0: sprite.flip_h = horizontal_direction == 1

func update_animation(direction: Vector2):
	if direction == Vector2.ZERO:
		ap.stop()
	else:
		ap.play("walk")
