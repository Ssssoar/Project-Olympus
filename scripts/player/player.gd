class_name Player extends CharacterBody2D

@export var input_handler: PlayerInputProcessor
@export var movement_handler: WalkMovement
@export var pick_handler: DashMovement
@export var movement_state_machine: PlayerMovementStateMachine

@export var default_params: movement_params

func _ready() -> void:
	initialize_movement_handler()
	initialize_pick_move_handler()

func initialize_movement_handler():
	movement_handler.body = self
	movement_handler.default_params = default_params
	movement_handler.input_handler = input_handler
	movement_handler.movement_state_machine = movement_state_machine

func initialize_pick_move_handler():
	pick_handler.player = self
	pick_handler.movement_handler = movement_handler
	pick_handler.input_handler = input_handler
	pick_handler.movement_state_machine = movement_state_machine
