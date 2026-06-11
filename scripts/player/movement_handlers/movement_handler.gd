class_name MovementHandler extends Node

@export var player_state: Enums.Player_Movement_State
@export var chatty: bool

var disabled:
	set(value):
		disabled = value

func _on_player_movement_state_machine_player_movement_state_changed(state_changed_to: int, _state_changed_from: int) -> void:
	if (state_changed_to as Enums.Player_Movement_State) == player_state:
		disabled = false
		if chatty: print("[MOVEMENT HANDLER]: was enabled by state transition")
	else:
		disabled = true
		if chatty: print("[MOVEMENT HANDLER]: was disabled by state transition")
