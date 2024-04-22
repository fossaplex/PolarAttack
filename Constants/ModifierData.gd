class ModifierData:
	var title: String
	var description: String
	var texture: String
	var type: ModifierType.Type
	var create_modifier_callable: Callable
	func _init(
		title: String,
		description: String,
		texture: String,
		_type: ModifierType.Type,
		_create_modifier_callable: Callable
	) -> void:
		self.type = _type
		self.create_modifier_callable = _create_modifier_callable

static var level : int = 1


static func get_modifier_data(key: int) -> ModifierData:
	if key not in DATA: return
	return DATA[key]

static func on_update_current_level_label(value : int) -> void:
	level = value

static var DATA := {
	0: ModifierData.new(
		"+ health",
		"add +" + str(level * 10) + " to base health",
		"texture",
		ModifierType.Type.PLAYER,
		func(player: Player)-> Modifier: return PlayerHealthModifier.createPlayerHealthModifier(player, level * 10)
	),
	1: ModifierData.new(
		"+ base damage",
		"add +" + str(10) + "to base damage of all current weapons",
		"texture",
		ModifierType.Type.WEAPON,
		func(weapons: Array)-> Modifier:return WeaponBaseDamageIncreaseModifier.createWeaponBaseDamageIncreaseModifier(weapons, 10)
	),
	2: ModifierData.new(
		"+ orb count and speed",
		"add +" + str(2) + "orbs and increses orb speed +" + str(100),
		"texture",
		ModifierType.Type.ORBS,
		func(orbs: Orbs) -> Modifier: return OrbCountAndSpeedIncreaseModifier.createOrbCountAndSpeedIncreaseModifier(orbs, 2, 100)
	)
}
