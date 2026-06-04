class_name PlayerInputProcessor extends Node
 ##This script's function is only to process controller inputs and store them as relevant variables
##Actual movement of the player will happen in a script that inherits from this one.
var horizontal_input : float ##a number from -1 to 1
var jump_input : Enums.Button_State ##representing whether the button is pressed or not.
var down_input : Enums.Button_State
var pickl_input : Enums.Button_State
var pickr_input : Enums.Button_State
var no_input: bool

func _physics_process(_delta: float) -> void:
	#record the right state for horizontal movement
	horizontal_input = Input.get_axis("Left" , "Right")
	
	#record the right state for button inputs
	jump_input = button_state("Jump")
	down_input = button_state("Down")
	pickl_input = button_state("PickL")
	pickr_input = button_state("PickR")
	
	if horizontal_input == 0 && jump_input == Enums.Button_State.OFF:
		no_input = true
	else:
		no_input = false

func button_state(action_name: String) -> Enums.Button_State:
	if (Input.is_action_just_pressed(action_name)):
		return Enums.Button_State.PRESSED
	elif(Input.is_action_just_released(action_name)):
		return Enums.Button_State.RELEASED
	elif(Input.is_action_pressed(action_name)):
		return Enums.Button_State.HELD
	else:
		return Enums.Button_State.OFF
