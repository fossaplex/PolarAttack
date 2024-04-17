extends Label

@onready var player := $".." as Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = ""
	text += str("H", player.health, "/", player.total_health, "\n")
	text += str("S", player.speed, "\n")
	if (player.health > 0):
		text += str("L", player.beam.attackable.damage, "\n")
		text += str("O", player.orbs.damage, "\n")

