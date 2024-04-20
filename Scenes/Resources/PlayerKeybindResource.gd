class_name PlayerKeybindResource
extends Resource

const MOVE_LEFT : String = "move_left"
const MOVE_RIGHT: String = "move_right"
const MOVE_UP : String = "move_up"
const MOVE_DOWN: String = "move_down"
const PRIMARY_ATTACK : String = "primary_attack"
const SECONDARY_ATTACK: String = "secondary_attack"

@export var DEFAULT_MOVE_LEFT_KEY := InputEventKey.new()
@export var DEFAULT_MOVE_RIGHT_KEY := InputEventKey.new()
@export var DEFAULT_MOVE_UP_KEY := InputEventKey.new()
@export var DEFAULT_MOVE_DOWN_KEY := InputEventKey.new()
@export var DEFAULT_PRIMARY_ATTACK_INPUT := InputEventMouseButton.new()
@export var DEFAULT_SECONDARY_ATTACK_INPUT := InputEventMouseButton.new()

var move_left_key: InputEvent
var move_right_key: InputEvent
var move_up_key: InputEvent
var move_down_key: InputEvent
var primary_attack_button: InputEvent
var secondary_attack_button: InputEvent
