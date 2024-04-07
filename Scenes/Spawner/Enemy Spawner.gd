extends Node2D
var seal = preload("res://Scenes/Enemies/Enemy 1/Seal.tscn")
var moab = preload("res://Scenes/Enemies/Enemy 2/Moab.tscn")
var counter = 0
 
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var enemy_seal = seal.instantiate()
	var enemy_moab = moab.instantiate()
	var enemy_list = [enemy_seal, enemy_moab]
	var r = randi_range(0,1) 
	add_child(enemy_list[r])
	counter+=1
	print(counter)
	#wait_time = 1
	pass # Replace with function body.
