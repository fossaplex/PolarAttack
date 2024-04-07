extends Node2D

const MAX_LENGTH = 2000

@onready var beam = $Beam
@onready var end = $End
@onready var raycast: RayCast2D = $RayCast2D

func _physics_process(delta: float):
	var mouse_position = get_local_mouse_position()
	var max_cast_to = mouse_position.normalized() * MAX_LENGTH
	raycast.target_position = max_cast_to
	if raycast.is_colliding():
		end.global_position = raycast.get_collision_point()
	else:
		end.global_position = raycast.target_position
	beam.rotation = raycast.target_position.angle()
	beam.region_rect.end.x = end.position.length()
