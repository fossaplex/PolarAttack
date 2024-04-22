extends Label

@onready var player := $".." as Player

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = ""
	text += str("H", player.health, "/", player.total_health, "\n")
	text += str("S", player.speed, "\n")
	var _weapons := player.weapon_handler.weapons
	#if weapons:
		#for weapon: Weapon in player.weapon_handler.weapons.get_children():
			#text += str(weapon.name, weapon.attackable.damage, "\n")

