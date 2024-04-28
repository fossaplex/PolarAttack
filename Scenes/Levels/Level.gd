class_name Level
extends Node2D

const Modifiers := preload("res://Constants/Modifiers.gd")

signal toggle_game_paused(is_paused : bool)
@onready var player := $Player as Player
@onready var timer := $EnemySpawner/Timer as Timer
@onready var seals := $Seals
@onready var upgrade_menu := $CanvasLayer/UpgradeMenu as UpgradeMenu

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
	PlayerXpSignalBus.on_level_change.connect(Modifiers.on_level_change)

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("esc"):
		game_paused = !game_paused

func _on_player_on_dead(_prev_health: int) -> void:
	timer.stop()
	for seal in seals.get_children():
		if seal is Seal:
			seal.target = null

func add_modifier(modifier: Modifier) -> void:
	var modifier_type := modifier.get_type()
	match modifier_type:
		ModifierType.Type.PLAYER:
			player.add_modifier(modifier)
		ModifierType.Type.WEAPON:
			player.add_modifier(modifier)
		ModifierType.Type.ORBS:
			player.add_modifier(modifier)

