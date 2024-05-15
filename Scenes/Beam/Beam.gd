class_name Beam
extends Weapon

const GROUPS := preload("res://Constants/Groups.gd")

var max_length := 100.0

@onready var beam := $Beam as Sprite2D
@onready var begin := $Begin as Sprite2D 
@onready var end := $End as Node2D
@onready var raycast := $RayCast2D as RayCast2D
@onready var beam_point_light_2d: PointLight2D = $BeamPointLight2D
@onready var begin_point_light_2d: PointLight2D = $Begin/BeginPointLight2D
@onready var end_point_light_2d: PointLight2D = $End/EndPointLight2D
@export var light_color: Color = Color("#ed0006ff"):
	set(value):
		light_color = value
		if not is_node_ready(): return
		beam_point_light_2d.color = light_color
		begin_point_light_2d.color = light_color
		end_point_light_2d.color = light_color

var direction: Vector2:
	get: return raycast.target_position.direction_to(begin.position).normalized()

@export var active := false:
	set(value):
		active = value
		if not is_node_ready(): return
		raycast.collide_with_areas = active
		visible = active

var active_last_frame := false

func _ready() -> void:
	super()
	light_color = light_color
	active = active

func _physics_process(_delta: float) -> void:
	if raycast.is_colliding():
		end.global_position = raycast.get_collision_point()
	else:
		end.position = raycast.target_position
	beam.rotation = raycast.target_position.angle()
	beam_point_light_2d.rotation = raycast.target_position.angle()
	beam_point_light_2d.scale.x = 4.17 * end.position.length() / 100.215
	beam.region_rect.end.x = end.position.length()


