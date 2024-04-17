extends SingleFiniteStateMachine

@onready var idle_state := $IdleState as PlayerIdleState
@onready var death_state := $DeathState as PlayerDeathState

@onready var beam := $"../Projectiles/Beam" as Beam
@onready var sprite := $"../Sprite2D" as Sprite2D
@onready var player := $".." as Player

func transition(destination_state : State) -> State:
	if (_current_state == death_state):
		return null
	return super(destination_state)

func process_input(event: InputEvent) -> void:
	super(event)
	if !beam: return
	if Input.is_action_pressed("primary_attack"):
		beam.visible = true
		beam.raycast.collide_with_areas = true
		player.speed_multiplier = 0.2
	else:
		beam.visible = false
		beam.raycast.collide_with_areas = false
		player.speed_multiplier = 1

func process_frame(delta: float) -> void:
	super(delta)
	if !beam || !beam.visible: return
	var direction := beam.raycast.target_position.direction_to(player.global_position).normalized()
	sprite.flip_h = direction.x < 0
