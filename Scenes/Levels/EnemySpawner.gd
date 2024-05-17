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
@onready var enemy_respawn_progress_bar: ProgressBar = $"../CanvasLayer/EnemyRespawnProgressBar"

var _level := 1
var seal_count: int:
	get: return _level * 2

var fox_count: int:
	get: return _level

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	PlayerXpSignalBus.on_level_change.connect(on_level_change)
	timer.wait_time =  20
	for spawn_point in spawn_points.get_children():
		if (spawn_point is Marker2D):
			markers.append(spawn_point)

func _process(_delta: float) -> void:
	enemy_respawn_progress_bar.value = timer.time_left
	enemy_respawn_progress_bar.max_value = timer.wait_time

func _on_timer_timeout() -> void:
	var seal_spawn_points := spawn_points.get_children()
	seal_spawn_points.shuffle()
	for i: int in range(seal_count):
		var index := i % seal_spawn_points.size()
		var spawn_point := seal_spawn_points[index] as Marker2D
		create_seal(spawn_point)
	var fox_available_spawn_points := fox_spawn_points.get_children().filter(
		func(node: FoxMarker2D)-> bool:
			var fox := node.fox
			if not fox: return true
			var current_state := fox.single_finite_state_machine._current_state
			if not current_state: return false
			return (current_state == FoxWakeState or current_state == FoxIdleState or current_state == FoxSleepState)
	)
	fox_available_spawn_points.shuffle()
	for i: int in range(min(fox_count, fox_available_spawn_points.size())):
		var index := i % fox_available_spawn_points.size()
		var spawn_point := fox_available_spawn_points[index] as FoxMarker2D
		create_fox(spawn_point)

func create_seal(spawn_point: Marker2D) -> void:
	var seal := SEAL_SCENE.instantiate() as Seal
	seals.add_child(seal)
	seal.target = player
	seal.attackable.update(1, _level + 2)
	seal.base_total_health = 30 + (_level + 2) 
	seal.health = seal.base_total_health
	seal.global_position = spawn_point.global_position
	seal.on_death.connect(spawn_xp)
	seal.base_speed = 50 + (_level + 2) 

func create_fox(spawn_point: FoxMarker2D) -> void:
	var fox := FOX_SCENE.instantiate() as Fox
	spawn_point.fox = fox
	foxes.add_child(fox)
	fox.attackable.update(1, _level + 2)
	fox.base_total_health = 30 + (_level + 2) 
	fox.health = fox.base_total_health
	fox.fox_chase_state.speed =  150 + (_level + 2) 
	fox.setup_done = true
	fox.global_position = spawn_point.global_position
	fox.on_death.connect(spawn_xp)

func spawn_xp(sealLocation: Vector2, xp_resource: ExperienceResource) -> void:
	var xp := XP_SCENE.instantiate()
	collectables.call_deferred("add_child", xp)
	xp.set_deferred("collectable_resource", xp_resource)
	xp.set_deferred("global_position", sealLocation)

func on_level_change(level: int, _prev_level: int) -> void:
	_level = level
	timer.wait_time = 20
	if seals.get_children().size() == 0:
		timer.stop()
		call_deferred("_on_timer_timeout")
		timer.start()
