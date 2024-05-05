class_name SealFiniteStateMachine
extends SingleFiniteStateMachine

@onready var animation_player := $"../AnimationPlayer"
@onready var death_state := $DeathState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func transition_to(source_state: State, destination_state : State, force: bool = false) -> State:
	if _current_state != death_state:
		return super(source_state, destination_state, force)
	return null
