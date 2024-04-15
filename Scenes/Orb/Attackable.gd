extends Attackable

const GROUPS = preload("res://Constants/Groups.gd")

func _on_orb_area_entered(area: Area2D):
	var groups = area.get_groups()
	if area.is_in_group(GROUPS.ENEMY_HITBOX):
		if area is CharacterHitbox:
			deal_damange(area.character)
