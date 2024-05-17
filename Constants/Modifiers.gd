static var level : Level

const Int := preload("res://Constants/Int.gd")

static var MODIFIER_DATUM : Array[ModifierData] = [
	#player
	ModifierData.new(2,Int.INT32_MAX,func() -> Modifier: return PlayerHealthModifier.new(10, level.player_level)),
	ModifierData.new(2,Int.INT32_MAX,func() -> Modifier: return PlayerMoveSpeedModifier.new(10, level.player_level)),
	#weapon
	ModifierData.new(2,Int.INT32_MAX,func() -> Modifier: return WeaponBaseDamageIncreaseModifier.new(10, level.player_level)),

	#orb
	ModifierData.new(2,Int.INT32_MAX,
		func() -> Modifier: return OrbCountIncreaseModifier.new(1, level.player_level),
		func () -> float:  return 1.0  if not _require_weapon(WeaponType.WEAPON_TYPE.ORB) else -1.0
	),
	ModifierData.new(2,Int.INT32_MAX,
		func() -> Modifier: return IncreaseOrbSpeedModifier.new(5, level.player_level),
		func () -> float:  return 0.0 if not _require_weapon(WeaponType.WEAPON_TYPE.ORB) else -1.0
	),
	ModifierData.new(2,Int.INT32_MAX,
		func() -> Modifier: return IncreaseOrbDamageModifier.new(5, level.player_level),
		func () -> float:  return 0.0  if not _require_weapon(WeaponType.WEAPON_TYPE.ORB) else -1.0
	),

	#sword
	ModifierData.new(2,Int.INT32_MAX,
		func() -> Modifier: return AddSwordWeaponModifier.new(1, level.player_level),
		func () -> float: return 1.0  if not _require_weapon(WeaponType.WEAPON_TYPE.SWORD) else -1.0
	),
	ModifierData.new(2,Int.INT32_MAX,
		func() -> Modifier: return IncreaseSwordFireRateModifier.new(0.1, level.player_level),
		_increase_sword_fire_rate_modifier
	),
	ModifierData.new(2,Int.INT32_MAX,
		func() -> Modifier: return IncreaseSwordSpeedModifier.new(5, level.player_level),
		func () -> float: return 0.0 if not _require_weapon(WeaponType.WEAPON_TYPE.SWORD) else -1.0
	),
	ModifierData.new(2,Int.INT32_MAX,
		func() -> Modifier: return IncreaseSwordDamageModifier.new(5, level.player_level),
		func() -> float: return 0.0 if not _require_weapon(WeaponType.WEAPON_TYPE.SWORD) else -1.0
	),

	#beam
	ModifierData.new(2,Int.INT32_MAX,
		func() -> Modifier: return IncreaseLaserLengthModifier.new(5, level.player_level),
		func() -> float: return 0.0 if not _require_weapon(WeaponType.WEAPON_TYPE.BEAM) else -1.0
	),
	ModifierData.new(2,Int.INT32_MAX,
		func() -> Modifier: return IncreaseLaserDamageModifier.new(5, level.player_level),
		func() -> float: return 0.0 if not _require_weapon(WeaponType.WEAPON_TYPE.SWORD) else -1.0
	),
]

static func get_modifiers(max_size: int) -> Array[Modifier]:
	var probabilities : Array[float] = []
	for modifier_data in MODIFIER_DATUM:
		probabilities.append(modifier_data.get_weight(level.player_level))
	var selected_indice := _select_multiple_unique_indices(probabilities, max_size)
	var modifiers: Array[Modifier] = []
	for index: int in selected_indice:
		modifiers.append(MODIFIER_DATUM[index].modifier_creator.call())
	return modifiers

# Normalizes the probabilities to ensure their sum equals 1.
static func _normalize_probabilities(probabilities: Array[float]) -> Array[float]:
	var sum := 0.0
	for p in probabilities:
		sum += p

	var normalize_probabilities: Array[float] = []
	for probability in probabilities:
		normalize_probabilities.append(probability / sum)
	return normalize_probabilities

# Selects a single index based on the given probabilities.
static func _select_index(probabilities: Array[float]) -> int:
	var random_value := randf()
	var accumulated := 0.0
	for i in range(probabilities.size()):
		accumulated += probabilities[i]
		if random_value < accumulated:
			return i
	# Theoretically should not reach here if probabilities are normalized correctly
	return -1 # Return an error value or handle this edge case appropriately

# Selects multiple unique indices based on the probabilities, ensuring no index is selected more than once.
static func _select_multiple_unique_indices(probabilities: Array[float], max_size: int) -> Array[int]:
	if max_size > probabilities.size():
		return []	

	var working_probabilities := probabilities.duplicate()
	var selected_indices : Array[int] = []
	
	var pickable_size := probabilities.size() - probabilities.count(0)
	var size := min(max_size, pickable_size) as int
	for i in range(size):
		working_probabilities = _normalize_probabilities(working_probabilities)
		var index := _select_index(working_probabilities)
		if index == -1: 
			return selected_indices
		selected_indices.append(index)
		working_probabilities[index] = 0 # Set the selected index's probability to zero

	return selected_indices

# weight overrides
static func _add_weapon_modifier_weight_override(weapon_type: WeaponType.WEAPON_TYPE) -> float:
	if _require_weapon(weapon_type): 
		return 0.0
	if (2 >= level.player_level and level.player_level <= 2):
		return -1.0
	else:
		return -1.0

static func _require_weapon_ovrride(weapon_type: WeaponType.WEAPON_TYPE) -> float:
	if not _require_weapon(weapon_type): 
		return 0.0
	else: return -1.0

static func _require_weapon(weapon_type: WeaponType.WEAPON_TYPE) -> bool:
	var  weapons_node := level.player.weapon_handler.weapons
	for weapon: Weapon in weapons_node.get_children():
		match weapon_type:
			WeaponType.WEAPON_TYPE.ORB: if weapon is Orbs: return true
			WeaponType.WEAPON_TYPE.BEAM: if weapon is Beam: return true
			WeaponType.WEAPON_TYPE.SWORD: if weapon is Swords: return true
	return false

static func _increase_sword_fire_rate_modifier() -> float:
	if not _require_weapon(WeaponType.WEAPON_TYPE.SWORD):
		return 0.0
	for weapon: Weapon in  level.player.weapon_handler.weapons.get_children():
		if weapon is Swords:
			if weapon.cooldown <= 1: 
				return 0.0
	return -1
