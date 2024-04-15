extends FiniteStateMachine

@export var animation_player: AnimationPlayer
@export var spirte: Sprite2D
@export var seal: Character
@onready var death_state = $DeathState

func transition_to(source_state: State, destination_state : State) -> void:
	if current_state != death_state:
		super(source_state, destination_state)
