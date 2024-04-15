extends Label
@onready var player := $".." as Player

func _process(delta):
	text = ""
	var orbs = player.orbs
	if orbs != null:
		var orb = orbs.get_child(0)
		if orb is Orb:
			text += str("orb damage ", orb.attackable.damage, "\n")
			text += str("orb radius ", orb.radius, "\n")
			text += str("orb speed ", orb.speed, "\n")
		text += str("orb count ", player.orbs.get_child_count(), "\n")
		text += str("orb damage ", player.beam.attackable.damage, "\n")
	
	text += str("player health ", player.health, "\n")
	text += str("player speed ", player.walk_state.speed, "\n")
