class_name WeaponHandler
extends Node2D
const Modifiers = preload("res://Constants/Modifiers.gd")
const BEAM := preload("res://Scenes/Beam/PlayerBeam.tscn") as PackedScene
const ORB := preload("res://Scenes/Orbs/Orbs.tscn") as PackedScene

@onready var beam_marker: Marker2D = $WeaponPositionMarkers/BeamMarker
@onready var orb_marker: Marker2D = $WeaponPositionMarkers/OrbMarker
@onready var weapons: Node2D = $Weapons
@onready var player: Player = $".."
@onready var modifiers: Node = $Modifiers

func _ready() -> void:
	player.on_dead.connect(on_dead)

func add_weapon(type: WeaponType.WEAPON_TYPE, base_damage: float = 1000, damage_multiplier: float = 1) -> void: 
	match type:
		WeaponType.WEAPON_TYPE.ORB:
			var already_has_weapon := weapons.get_children().any(func(x: Node) -> bool: return x is Orbs)
			if already_has_weapon: return
			var weapon_scene := ORB
			var weapon := weapon_scene.instantiate() as Orbs
			weapons.add_child(weapon)
			weapon.attackable.update(base_damage, damage_multiplier)
			weapon.global_position = orb_marker.global_position
		WeaponType.WEAPON_TYPE.BEAM:
			var already_has_weapon := weapons.get_children().any(func(x: Node) -> bool: return x is Beam)
			if already_has_weapon: return
			var weapon_scene := BEAM
			var weapon := weapon_scene.instantiate() as Beam
			weapons.add_child(weapon)
			weapon.attackable.update(base_damage, damage_multiplier)
			weapon.on_beam_active.connect(player.on_beam_active)
			weapon.global_position = beam_marker.global_position

func on_dead(_prev_health: int) -> void:
	weapons.queue_free()

func add_modifier(modifier: Modifier) -> void:
	if modifier is WeaponModifier:
		modifier.add_dependecies(self)
		modifiers.add_child(modifier)
	elif modifier is OrbsModifier:
		var orbs :Orbs = null
		for weapon: Weapon in weapons.get_children():
			if weapon is Orbs:
				orbs = weapon
				break
		if !orbs: return
		modifier.add_dependecies(orbs)
		modifiers.add_child(modifier)
