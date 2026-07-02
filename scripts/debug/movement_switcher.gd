class_name MovementSwitcher extends Node

@export var move_handler: MovementHandler
@export var params1: MovementParams
@export var params2: MovementParams
@export var params3: MovementParams
@export var params4: MovementParams

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("TEST_SWITCH_1"):
		move_handler.set_params(params1)
	if Input.is_action_just_pressed("TEST_SWITCH_2"):
		move_handler.set_params(params2)
	if Input.is_action_just_pressed("TEST_SWITCH_3"):
		move_handler.set_params(params3)
	if Input.is_action_just_pressed("TEST_SWITCH_4"):
		move_handler.set_params(params4)
