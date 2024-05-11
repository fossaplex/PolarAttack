class_name Swords
extends Weapon
const Weapon = preload("res://Scripts/Weapon.gd")
const SWORD_SCENE = preload("res://Scenes/Weapons/Swords/Sword.tscn")


@onready var start_marker: Marker2D = $Markers/StartMarker
@onready var end_marker: Marker2D = $Markers/EndMarker
@onready var swords_container: Node = $SwordsContainer
@onready var timer: Timer = $Timer
@onready var middle_marker_2d: Marker2D = $Markers/MiddleMarker2D
@onready var markers: Node2D = $Markers

@export var count: int = 3
@export var cooldown := 3.0:
	set(value):
		cooldown = value
		timer.wait_time = value

@export var speed := 100.0

func _ready() -> void:
	super()
	cooldown = cooldown
	timer.timeout.connect(on_timer)

func _process(_delta: float) -> void:
	markers.rotation = position.angle_to(get_local_mouse_position())

func on_timer() -> void:
	var horizontal_distance := absf(end_marker.global_position.x - start_marker.global_position.x)
	var vertical_distance :=  absf(end_marker.global_position.y - start_marker.global_position.y)
	var subdivide_x := horizontal_distance / (count + 1)
	var subdivide_y := vertical_distance / (count + 1)

	var start_x := minf(start_marker.global_position.x, end_marker.global_position.x)
	var start_y := minf(start_marker.global_position.y, end_marker.global_position.y)
	print(
		"start_x:", start_x, "\n",
		 "start_y:", start_y, "\n",
		 "horizontal_distance:", horizontal_distance, "\n",
		 "vertical_distance:", vertical_distance, "\n",
		"subdivide_x:", subdivide_x, "\n",
		"subdivide_y:", subdivide_y, "\n",
		"=================", "\n"
		)
	
	var mouse_positon := get_global_mouse_position()
	var direction := middle_marker_2d.global_position.direction_to(mouse_positon)
	var angle := middle_marker_2d.global_position.angle_to(get_local_mouse_position())

	for i in range(count):
		var sword := SWORD_SCENE.instantiate() as Sword
		sword.attackable = attackable
		var x := start_x + ((i + 1) * subdivide_x)
		var y := start_y + ((i + 1) * subdivide_y)
		swords_container.add_child(sword)
		sword.global_position = Vector2(x, y)
		sword.speed = speed
		sword.launch(direction, angle)
