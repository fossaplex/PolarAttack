class ModifierData:
	var title: String
	var description: String
	var texture: Resource
	var type: ModifierType.Type
	var create_modifier_callable: Callable
	var key: int

	func _init(
		_title: String,
		_description: String,
		_texture: Resource,
		_type: ModifierType.Type,
		_key: int,
		_create_modifier_callable: Callable
	) -> void:
		self.title = _title
		self.description = _description
		self.texture = _texture
		self.type = _type
		self.key = _key
		self.create_modifier_callable = _create_modifier_callable
	

static var level : int = 1


static func get_modifier_data(key: int) -> ModifierData:
	if key not in DATA: return
	return DATA[key]

static func on_update_current_level_label(value : int) -> void:
	level = value

static var DATA := {
	-1: ModifierData.new(
		"** orb **",
		"gain spinning orb weapon",
		preload("res://Graphics/Icons/icon.svg"),
		ModifierType.Type.WEAPON,
		-1,
		func(weapon_handler: WeaponHandler)-> Modifier: return AddWeaponModifier.createAddWeaponModifier(weapon_handler, WeaponType.WEAPON_TYPE.ORB)
	),
	0: ModifierData.new(
		"+ health",
		"add +" + str(level * 10) + " to base health",
		preload("res://Graphics/Icons/icon.svg"),
		ModifierType.Type.PLAYER,
		0,
		func(player: Player)-> Modifier: return PlayerHealthModifier.createPlayerHealthModifier(player, level * 10)
	),
	1: ModifierData.new(
		"+ base damage",
		"add +" + str(10) + "to base damage of all current weapons",
		preload("res://Graphics/Icons/icon.svg"),
		ModifierType.Type.WEAPON,
		1,
		func(weapons: Array)-> Modifier:return WeaponBaseDamageIncreaseModifier.createWeaponBaseDamageIncreaseModifier(weapons, 10)
	),
	2: ModifierData.new(
		"+ orb count and speed",
		"add +" + str(2) + "orbs and increses orb speed +" + str(100),
		preload("res://Graphics/Icons/icon.svg"),
		ModifierType.Type.ORBS,
		2,
		func(orbs: Orbs) -> Modifier: return OrbCountAndSpeedIncreaseModifier.createOrbCountAndSpeedIncreaseModifier(orbs, 2, 100)
	)
}
