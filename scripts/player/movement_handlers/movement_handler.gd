class_name MovementHandler extends Node

@export var player_state: Enums.Player_Movement_State

var disabled

func _on_player_movement_state_machine_player_movement_state_changed(state_changed_to: int, _state_changed_from: int) -> void:
	if (state_changed_to as Enums.Player_Movement_State) == player_state:
		disabled = false
	else:
		disabled = true
