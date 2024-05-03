class_name Modifier
extends Node

var level: int = 0

func _init(_level: int) -> void:
	level = _level

func get_title() -> String:
	return ""

func get_description() -> String:
	return ""

func get_texture() -> Resource:
	return null

func get_key() -> int:
	return 0

func get_tag() -> String:
	return ""


