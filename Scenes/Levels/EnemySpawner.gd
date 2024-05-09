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

	for spawn_point: Marker2D in fox_spawn_points.get_children():
		var fox := FOX_SCENE.instantiate() as Fox
		foxes.add_child(fox)
		fox.global_position = spawn_point.global_position
		fox.on_death.connect(spawn_xp)

func _on_timer_timeout() -> void:
	for spawn_point: Marker2D in spawn_points.get_children():
		if spawn_point is Marker2D:
			Seal.instanciate_seal(
				player,
				10,
				1,
				spawn_point.global_position,
				seals,
				spawn_xp
			)


func spawn_xp(sealLocation: Vector2, xp_resource: ExperienceResource) -> void:
	var xp := XP_SCENE.instantiate()
	collectables.call_deferred("add_child", xp)
	xp.set_deferred("collectable_resource", xp_resource)
	xp.set_deferred("global_position", sealLocation)

func on_level_change(level: int, _prev_level: int) -> void:
	timer.wait_time = (1.0 / level) * 20 + 7
