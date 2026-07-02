class_name Player extends CharacterBody2D

@export var input_handler: PlayerInputProcessor
@export var movement_handler: WalkMovement
@export var pick_handler: DashMovement
@export var movement_state_machine: PlayerMovementStateMachine
@export var pick_reaction_handler: PickReactor
@export var cling_handler: ClingMovement
@export var collision_checker: PlayerCollisionChecker
@export var game_over_handler: GameOverHandler

@export var default_params: MovementParams
@export var can_dash: bool

func _ready() -> void:
	initialize_movement_handler()
	initialize_pick_move_handler()
	initialize_pick_reaction_handler()
	initialize_cling_move_handler()
	initialize_collision_checker()
	initialize_game_over_handler()

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

func initialize_pick_reaction_handler():
	pick_reaction_handler.movement_state_machine = movement_state_machine

func initialize_cling_move_handler():
	cling_handler.movement_state_machine = movement_state_machine
	cling_handler.input_handler = input_handler

func initialize_collision_checker():
	collision_checker.player = self

func initialize_game_over_handler():
	game_over_handler.player = self
