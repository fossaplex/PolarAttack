extends Node2D
var seal = preload("res://Scenes/Enemies/Enemy 1/Seal.tscn")
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
	add_child(enemy_seal)
	counter+=1
	print(counter)
	#wait_time = 1
	pass # Replace with function body.
