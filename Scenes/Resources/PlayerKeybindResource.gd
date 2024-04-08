class_name PlayerKeybindResource
extends Resource

const MOVE_LEFT : String = "move_left"
const MOVE_RIGHT: String = "move_right"
const MOVE_UP : String = "move_up"
const MOVE_DOWN: String = "move_down"
const PRIMARY_ATTACK : String = "primary_attack"
const SECONDARY_ATTACK: String = "secondary_attack"

@export var DEFAULT_MOVE_LEFT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_UP_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_DOWN_KEY = InputEventKey.new()
#TODO v
@export var DEFAULT_PRIMARY_ATTACK_INPUT = InputEventKey.new()
@export var DEFAULT_SECONDARY_ATTACK_INPUT = InputEventKey.new()

var move_left_key = InputEventKey.new()
var move_right_key = InputEventKey.new()
var move_up_key = InputEventKey.new()
var move_down_key = InputEventKey.new()
var primary_attack_key = InputEventKey.new()
var secondary_attack_key = InputEventKey.new()
