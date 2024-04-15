extends Timer

const seal_scenes = preload("res://Scenes/Enemies/Seal/seal.tscn")

var markers: Array[Marker2D] = []
@onready var spawn_points = $SpawnPoints
@onready var player = $"../Player"
@onready var seals = $"../Seals"

func _ready():
	for spawn_point in spawn_points.get_children():
		if (spawn_point is Marker2D):
			markers.append(spawn_point)

func _on_timeout():
	for spawn_point in spawn_points.get_children():
		var seal := seal_scenes.instantiate()
		seal.target = player
		seal.global_position = spawn_point.global_position
		seals.add_child(seal)


func _on_player_is_dead():
	stop()
	for seal in seals.get_children():
		if seal is Seal:
			seal.target = null
