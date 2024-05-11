extends Node2D

const FOX_SCENE = preload("res://Scenes/Enemies/Fox/Fox.tscn")
const SEAL_SCENE :=  preload("res://Scenes/Enemies/Enemy 1/Seal.tscn")
const XP_SCENE := preload("res://Scenes/Collectables/BaseCollectableEntity/BaseCollectableEntity.tscn")

var markers: Array[Marker2D] = []

@onready var timer := $Timer
@onready var spawn_points := $SpawnPoints
@onready var player := $"../Player" as Player
@onready var seals := $"../Seals"
@onready var collectables := $"../Collectables"
@onready var fox_spawn_points: Node2D = $FoxSpawnPoints
@onready var foxes: Node2D = $"../Foxes"

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	PlayerXpSignalBus.on_level_change.connect(on_level_change)
	timer.wait_time =  20
	for spawn_point in spawn_points.get_children():
		if (spawn_point is Marker2D):
			markers.append(spawn_point)

func _on_timer_timeout() -> void:
	for spawn_point: Marker2D in spawn_points.get_children():
		if spawn_point is Marker2D:
			create_seal(spawn_point)
	var fox_available_spawn_points := fox_spawn_points.get_children().filter(
		func(node: FoxMarker2D)-> bool:
			var fox := node.fox
			if not fox: return true
			var current_state := fox.single_finite_state_machine._current_state
			if not current_state: return false
			return (current_state == FoxWakeState or current_state == FoxIdleState or current_state == FoxSleepState)
	)
	for spawn_point: FoxMarker2D in fox_available_spawn_points:
		create_fox(spawn_point)
			

func create_seal(spawn_point: Marker2D) -> void:
	var seal := SEAL_SCENE.instantiate() as Seal
	seals.add_child(seal)
	seal.target = player
	seal.attackable.update(5, 1)
	seal.base_total_health = 30
	seal.health = 30 
	seal.global_position = spawn_point.global_position
	seal.on_death.connect(spawn_xp)
	seal.base_speed = 50

func create_fox(spawn_point: FoxMarker2D) -> void:
	var fox := FOX_SCENE.instantiate() as Fox
	spawn_point.fox = fox
	foxes.add_child(fox)
	fox.attackable.update(5, 1)
	fox.base_total_health = 30
	fox.health = 30
	fox.setup_done = true
	fox.global_position = spawn_point.global_position
	fox.on_death.connect(spawn_xp)

func spawn_xp(sealLocation: Vector2, xp_resource: ExperienceResource) -> void:
	var xp := XP_SCENE.instantiate()
	collectables.call_deferred("add_child", xp)
	xp.set_deferred("collectable_resource", xp_resource)
	xp.set_deferred("global_position", sealLocation)

func on_level_change(level: int, _prev_level: int) -> void:
	timer.wait_time = (1.0 / level) * 20 + 7
