extends Label
const Weapon = preload("res://Scripts/Weapon.gd")
@onready var player := $".." as Player

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = ""
	text += str("H", player.health, "/", player.total_health, "\n")
	text += str("S", player.speed, "\n")
	var weapons := player.weapon_handler.weapons
	if weapons:
		if !weapons: return
		for weapon: Weapon in weapons.get_children():
			text += str(weapon.name, weapon.attackable.damage, "\n")

