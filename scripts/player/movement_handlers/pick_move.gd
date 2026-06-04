class_name DashMovement extends MovementHandler

## the below given by player node
var player: CharacterBody2D
var movement_handler: WalkMovement
var input_handler: PlayerInputProcessor
var movement_state_machine: PlayerMovementStateMachine

@export var impulse_timer: Timer
@export var pick_area_l: Area2D
@export var pick_area_r: Area2D

var current_params: movement_params
var current_direction: Enums.Facing
var on_cooldown: bool
var locked: bool

func _ready() -> void:
	current_direction = Enums.Facing.NONE

func _physics_process(_delta: float) -> void:
	react_to_input()
	if disabled: return
	if current_direction != Enums.Facing.NONE:
		apply_impulse()

func react_to_input():
	if locked: return
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
	movement_handler.kill_momentum()
	movement_handler.disabled = true
	on_cooldown = true
	current_params = movement_handler.current_active_params
	current_direction = direction
	impulse_timer.start(current_params.impulse_time)
	enable_area(direction)
	locked = true

func enable_area(direction: Enums.Facing):
	if direction == Enums.Facing.LEFT:
		pick_area_l.monitoring = true
	elif direction == Enums.Facing.RIGHT:
		pick_area_r.monitoring = true

func disable_areas():
	pick_area_l.monitoring = false
	pick_area_r.monitoring = false

func apply_impulse():
	var mult: int
	if current_direction == Enums.Facing.LEFT:
		mult = -1
	else:
		mult = 1
	player.velocity.y = 0
	player.velocity.x = mult * current_params.impulse_velocity
	player.move_and_slide()

func end_inpulse(): ##to end the impulse prematurely in case a wall is struck.
	current_direction = Enums.Facing.NONE
	current_params = null
	disable_areas()

func _on_impulse_timer_timeout() -> void:
	current_direction = Enums.Facing.NONE
	current_params = null
	disable_areas()
	movement_state_machine.try_change_player_movement_state(Enums.Player_Movement_State.NORMAL)
	locked = false
