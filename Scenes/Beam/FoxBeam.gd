extends Beam

@onready var fox: Fox = $"../../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../../AnimatedSprite2D"

func _ready() -> void:
	super()
	light_color = Color("#ffffff55")
	max_length = 2000
	raycast.set_collision_mask_value(1, true)

func _process(delta: float) -> void:
	var node := raycast.get_collider()
	if node is CharacterHitbox and node.is_in_group(GROUPS.PLAYER_HITBOX):
		attackable.deal_damange_delta(node.character, delta)

func _physics_process(_delta: float) -> void:
	super(_delta)
	if active and fox.target:
		var max_cast_to := fox.target.to_local(global_position).normalized() * -1 * max_length
		raycast.target_position = max_cast_to
