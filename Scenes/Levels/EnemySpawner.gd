extends Node2D

const SEAL_SCENE :=  preload("res://Scenes/Enemies/Enemy 1/Seal.tscn")
const XP_SCENE := preload("res://Scenes/Collectables/BaseCollectableEntity/BaseCollectableEntity.tscn")

var markers: Array[Marker2D] = []

@onready var timer := $Timer
@onready var spawn_points := $SpawnPoints
@onready var player := $"../Player" as Player
@onready var seals := $"../Seals"
@onready var collectables := $"../Collectables"

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	SignalBus.on_update_current_level_label.connect(on_update_current_level_label)
	timer.wait_time =  20
	for spawn_point in spawn_points.get_children():
		if (spawn_point is Marker2D):
			markers.append(spawn_point)

func _on_timer_timeout() -> void:
	for spawn_point in spawn_points.get_children():
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

func on_update_current_level_label(value : int)-> void:
	timer.wait_time = (1.0 / value) * 20 + 7
