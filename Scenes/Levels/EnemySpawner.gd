extends Node2D

const seal_scenes =  preload("res://Scenes/Enemies/Enemy 1/Seal.tscn")
const xp_scene = preload("res://Scenes/Collectables/BaseCollectableEntity/BaseCollectableEntity.tscn")

var markers: Array[Marker2D] = []

@onready var timer = $Timer
@onready var spawn_points := $SpawnPoints
@onready var player := $"../Player" as Player
@onready var seals := $"../Seals"
@onready var collectables := $"../Collectables"
func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer.start()
	timer.wait_time = 10
	for spawn_point in spawn_points.get_children():
		if (spawn_point is Marker2D):
			markers.append(spawn_point)

func _on_timer_timeout():
	for spawn_point in spawn_points.get_children():
		if spawn_point is Marker2D:
			var seal := seal_scenes.instantiate()
			
			seals.add_child(seal)
			seal.on_death.connect(spawnXp)
			seal.target = player
			seal.base_damage = 10
			seal.damage_multiplier = 1
			seal.attackable.damage  = seal.damage
			seal.global_position = spawn_point.global_position
			
func spawnXp(sealLocation: Vector2, xpResource: ExperienceResource):
	var xp := xp_scene.instantiate()
	collectables.call_deferred("add_child", xp)
	xp.set_deferred("collectable_resource", xpResource)
	xp.set_deferred("global_position", sealLocation)
	
	
