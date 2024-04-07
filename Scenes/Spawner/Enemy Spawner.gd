extends Node2D
var seal_scene = preload("res://Scenes/Enemies/Enemy 1/Seal.tscn")
var moab_scene = preload("res://Scenes/Enemies/Enemy 2/Moab.tscn")

func _ready():
	$Timer.start()

func _on_timer_timeout():
	var enemy_seal = seal_scene.instantiate()
	var enemy_moab = moab_scene.instantiate()
	var enemy_list = [enemy_seal, enemy_moab]
	var r = randi_range(0,1)
	add_child(enemy_list[r])
