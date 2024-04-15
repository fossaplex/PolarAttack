extends FiniteStateMachine

@onready var animation_player := $"../AnimationPlayer" as AnimationPlayer
@onready var spirte := $"../Sprite2D" as Sprite2D
@onready var seal : = $".." as Character
@onready var death_state = $DeathState
@onready var walk_state := $WalkState as SealWlakState
@onready var attak_state := $AttackState as SealAttackState
@export var attack_distance: int

func _ready():
	walk_state.animation_player = animation_player
	walk_state.seal = seal
	walk_state.attack_distance = attack_distance
	walk_state.sprite = spirte
	
	attak_state.animation_player = animation_player
	attak_state.seal = seal
	super()

	
func transition_to(source_state: State, destination_state : State) -> void:
	if current_state != death_state:
		super(source_state, destination_state)
