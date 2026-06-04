class_name PickMoveHandler extends Node

## the below given by player node
var player: CharacterBody2D
var movement_handler: PlayerMovement
var input_handler: PlayerInputProcessor

@export var impulse_timer: Timer
@export var cooldown_timer: Timer

var current_params: movement_params
var current_direction: Enums.Facing
var on_cooldown: bool

func _ready() -> void:
	current_direction = Enums.Facing.NONE

func _physics_process(_delta: float) -> void:
	if !on_cooldown:
		react_to_input()
	if current_direction != Enums.Facing.NONE:
		apply_impulse()

func react_to_input():
	var impulse_direction = get_current_impulse_input()
	if impulse_direction != Enums.Facing.NONE:
		begin_impulse(impulse_direction)

func get_current_impulse_input() -> Enums.Facing:
	if input_handler.pickl_input == Enums.Button_State.PRESSED:
		return Enums.Facing.LEFT
	elif input_handler.pickr_input == Enums.Button_State.PRESSED:
		return Enums.Facing.RIGHT
	else:
		return Enums.Facing.NONE

func begin_impulse(direction: Enums.Facing):
	movement_handler.disabled = true
	on_cooldown = true
	current_params = movement_handler.current_active_params
	current_direction = direction
	impulse_timer.start(current_params.impulse_time)
	cooldown_timer.start(current_params.impulse_time * 1.3) ##magic number :C

func apply_impulse():
	var mult: int
	if current_direction == Enums.Facing.LEFT:
		mult = -1
	else:
		mult = 1
	player.velocity.y = 0
	player.velocity.x = mult * current_params.impulse_velocity
	player.move_and_slide()

func _on_impulse_timer_timeout() -> void:
	current_direction = Enums.Facing.NONE
	movement_handler.disabled = false
	current_params = null

func _on_cooldown_timer_timeout() -> void:
	on_cooldown = false
