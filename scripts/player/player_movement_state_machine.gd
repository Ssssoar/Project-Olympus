class_name PlayerMovementStateMachine extends StateMachine

var current_movement_state: Enums.Player_Movement_State:
	get:
		return current_state as Enums.Player_Movement_State
	set(value):
		current_state = value as int

signal player_movement_state_changed(state_changed_to: Enums.Player_Movement_State, state_changed_from: Enums.Player_Movement_State)

func _process(_delta: float):
	super(_delta)
	pass

func initialize_transisitions_array():
	states = Enums.Player_Movement_State.values()
	super()
	possible_transitions[Enums.Player_Movement_State.NORMAL as int][Enums.Player_Movement_State.DASHING as int] = true
	possible_transitions[Enums.Player_Movement_State.DASHING as int][Enums.Player_Movement_State.CLINGING as int] = true
	possible_transitions[Enums.Player_Movement_State.DASHING as int][Enums.Player_Movement_State.NORMAL as int] = true
	possible_transitions[Enums.Player_Movement_State.CLINGING as int][Enums.Player_Movement_State.NORMAL as int] = true

func try_change_player_movement_state(target_state: Enums.Player_Movement_State) -> bool:
	var old_state = current_state
	if try_change_state(target_state as int):
		player_movement_state_changed.emit(target_state, old_state as Enums.Player_Movement_State)
		return true
	else:
		return false

func state_to_name(state: Enums.Player_Movement_State) -> String:
	match state:
		Enums.Player_Movement_State.NORMAL:
			return "NORMAL"
		Enums.Player_Movement_State.CLINGING:
			return "CLINGING"
		Enums.Player_Movement_State.DASHING:
			return "DASHING"
	return "NO STATE" ##which SHOULDNT HAPPENda
