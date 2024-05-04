@icon("res://Graphics/Icons/FSMSprite.png")
class_name SingleFiniteStateMachine
extends FiniteStateMachine

@export var _current_state : State

func transition_to(source_state: State, destination_state : State) -> State:
	if source_state and source_state != _current_state:
		return
	if destination_state == _current_state:
		return
	
	if _current_state: _current_state.exit()

	_current_state = destination_state
	_current_state.enter()
	return _current_state

func transition(destination_state : State) -> State:
	return transition_to(_current_state, destination_state)

func process_physics(delta: float) -> void:
	if !_current_state: return
	_current_state.process_physics(delta)

func process_frame(delta: float) -> void:
	super(delta) 
	if !_current_state: return
	if _current_state is PlayerWalkState:
		_current_state.process_frame(delta)
	_current_state.process_frame(delta)

func process_input(event: InputEvent) -> void:
	if !_current_state: return
	_current_state.process_input(event)

func has_current_state() -> bool:
	return _current_state != null
