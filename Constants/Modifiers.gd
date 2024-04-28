static var level : int = 1

static func on_level_change(_level: int, _prev_level: int) -> void: 
	level = _level

static var DATA := [
	func() -> Modifier: return AddWeaponModifier.new(WeaponType.WEAPON_TYPE.ORB),
	func() -> Modifier: return PlayerHealthModifier.new(level * 10),
	func() -> Modifier: return WeaponBaseDamageIncreaseModifier.new(10),
	func() -> Modifier: return OrbCountAndSpeedIncreaseModifier.new(2, 100)
]
