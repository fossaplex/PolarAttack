class_name FiniteStateMachine
extends State

func _process(delta: float) -> void:
	process_frame(delta)

func _physics_process(delta: float) -> void:
	process_physics(delta)

func _input(event: InputEvent) -> void:
	process_input(event)

func has_current_state() -> bool:
	return false

func transition(_destination_state : State, _force: bool = false) -> State:
	return null

func transition_to(_source_state: State, _destination_state : State, _force: bool = false) -> State:
	return null

func add_transition_to(_source_state: State, _destination_state: State, _append: bool, _remove_source: bool, _force: bool = false) -> State:
	return null
