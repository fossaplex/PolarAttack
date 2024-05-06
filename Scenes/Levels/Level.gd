class_name Level
extends Node2D

const Modifiers := preload("res://Constants/Modifiers.gd")

signal toggle_game_paused(is_paused : bool)
@onready var player := $Player as Player
@onready var timer := $EnemySpawner/Timer as Timer
@onready var seals := $Seals
@onready var upgrade_menu := $CanvasLayer/UpgradeMenu as UpgradeMenu

var player_level : int = 1:
	get: return player.player_xp_handler.current_level

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		toggle_game_paused.emit(game_paused)

func _ready() -> void:
	player.on_dead.connect(_on_player_on_dead)
	upgrade_menu.on_upgrade_pressed.connect(add_modifier)
	player.weapon_handler.add_weapon(WeaponType.WEAPON_TYPE.BEAM, 10000, 1)
	Modifiers.level = self
	PlayerXpSignalBus.on_level_change.connect(on_level_change)

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("esc"):
		game_paused = !game_paused

func _on_player_on_dead(_prev_health: int) -> void:
	timer.stop()
	for seal in seals.get_children():
		if seal is Seal:
			seal.target = null

func add_modifier(modifier: Modifier) -> void:
	if modifier is PlayerModifier:
		player.add_modifier(modifier)
	elif modifier is WeaponModifier:
		player.add_modifier(modifier)
	elif modifier is OrbsModifier:
		player.add_modifier(modifier)

func on_level_change(_level: int, _prev_level: int) -> void: 
	player_level = _level
