class_name Player extends CharacterBody2D

@export var input_handler: PlayerInputProcessor
@export var movement_handler: PlayerMovement
@export var pick_handler: PickMoveHandler

@export var default_params: movement_params

func _ready() -> void:
	initialize_movement_handler()
	initialize_pick_move_handler()

func initialize_movement_handler():
	movement_handler.body = self
	movement_handler.default_params = default_params
	movement_handler.input_handler = input_handler

func initialize_pick_move_handler():
	pick_handler.player = self
	pick_handler.movement_handler = movement_handler
	pick_handler.input_handler = input_handler
