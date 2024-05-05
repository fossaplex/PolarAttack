extends Beam

signal on_beam_active(is_active: bool, horizontal_direction: float)

func _ready() -> void:
	super()
	raycast.set_collision_mask_value(6, true)

func _physics_process(_delta: float) -> void:
	super(_delta)
	var mouse_position := get_local_mouse_position()
	var max_cast_to := mouse_position.normalized() * max_length
	raycast.target_position = max_cast_to

func _process(delta: float) -> void:
	var node := raycast.get_collider()
	if node is CharacterHitbox and node.is_in_group(GROUPS.ENEMY_HITBOX):
		attackable.deal_damange_delta(node.character, delta)

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("primary_attack"):
		active_last_frame = true
		active = true
		on_beam_active.emit(true, direction.x)
	elif active_last_frame:
		active_last_frame = false
		active = false
		on_beam_active.emit(false, 0)
