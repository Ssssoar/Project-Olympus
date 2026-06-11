class_name ClingMovement extends MovementHandler

var input_handler: PlayerInputProcessor
var movement_state_machine: PlayerMovementStateMachine

signal jumped()
signal dropped()

func _process(_delta: float) -> void:
	if disabled: return
	if input_handler.jump_input == Enums.Button_State.PRESSED:
		movement_state_machine.try_change_player_movement_state(Enums.Player_Movement_State.NORMAL)
		jumped.emit()
	elif input_handler.down_input == Enums.Button_State.PRESSED:
		movement_state_machine.try_change_player_movement_state(Enums.Player_Movement_State.NORMAL)
		dropped.emit()
