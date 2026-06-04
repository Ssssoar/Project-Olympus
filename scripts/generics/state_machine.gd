class_name StateMachine extends Node

@export var chatty: bool
@export var allow_multiple_state_changes_per_frame: bool

var states: Array
var possible_transitions = []
var current_state: int
var state_changed_this_frame: bool

signal state_changed(state_changed_to: int, state_changed_from: int)

func _ready():
	initialize_transisitions_array()

func _process(_delta: float) -> void:
	state_changed_this_frame = false

func initialize_transisitions_array():
	for possible_from_state in states:
		possible_transitions.append([])
		for possible_to_state in states:
			possible_transitions[possible_from_state].append(false)

func try_change_state(target_state: int):
	if !allow_multiple_state_changes_per_frame && state_changed_this_frame: 
		if chatty:
			print("[STATE MACHINE] refused transition (same frame) from " + state_to_name(current_state) + " to " + state_to_name(target_state))
		return false
	var old_state = current_state
	if is_valid_state_transition(current_state, target_state):
		if chatty:
			print("[STATE MACHINE] transitioned from " + state_to_name(current_state) + " to " + state_to_name(target_state))
		current_state = target_state
		state_changed.emit(target_state,old_state)
		state_changed_this_frame = true
		return true
	else:
		if chatty: 
			print("[STATE MACHINE] refused transition from " + state_to_name(current_state) + " to " + state_to_name(target_state))
		return false

func is_valid_state_transition(old_state: int, new_state: int) -> bool:
	return possible_transitions[old_state][new_state]

func state_to_name(state: int):
	return state as String
