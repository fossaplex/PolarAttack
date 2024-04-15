extends Node2D

const seal_scenes = preload("res://Scenes/Enemies/Seal/seal.tscn")

var markers: Array[Marker2D] = []

@onready var timer = $Timer
@onready var spawn_points = $SpawnPoints
@onready var player = $"../Player"
@onready var seals = $"../Seals"

func _ready():
	for spawn_point in spawn_points.get_children():
		if (spawn_point is Marker2D):
			markers.append(spawn_point)

func _on_timer_timeout():
	for spawn_point in spawn_points.get_children():
		if spawn_point is Marker2D:
			var seal := seal_scenes.instantiate()
			seal.target = player
			seal.damage = 1
			seals.add_child(seal)
			seal.global_position = spawn_point.global_position
