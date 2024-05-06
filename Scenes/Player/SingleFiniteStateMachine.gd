extends SingleFiniteStateMachine

@onready var idle_state := $IdleState as PlayerIdleState
@onready var death_state := $DeathState as PlayerDeathState

@onready var sprite := $"../Sprite2D" as Sprite2D
@onready var player := $".." as Player


func transition(destination_state : State) -> State:
	if (_current_state == death_state):
		return null
	return super(destination_state)
