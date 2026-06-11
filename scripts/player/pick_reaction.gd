class_name PickReactor extends Node

var movement_state_machine: PlayerMovementStateMachine

signal bounced(direction: Enums.Facing)
signal shattered()
signal clung()

func _on_pick_area_l_body_entered(body: Node2D) -> void:
	on_pick_area_entered(body, Enums.Facing.RIGHT)

func _on_pick_area_r_body_entered(body: Node2D) -> void:
	on_pick_area_entered(body, Enums.Facing.LEFT)

func on_pick_area_entered(body: Node2D, facing: Enums.Facing) -> void:
	if body is Ground:
		body = body as Ground
		body.strike()
		if body.type == Enums.Ground_Type.BOUNCE:
			movement_state_machine.try_change_player_movement_state(Enums.Player_Movement_State.NORMAL)
			bounced.emit(facing)
		if body.type == Enums.Ground_Type.BREAK:
			shattered.emit()
		if body.type == Enums.Ground_Type.CLING:
			movement_state_machine.try_change_player_movement_state(Enums.Player_Movement_State.CLINGING)
			clung.emit()
