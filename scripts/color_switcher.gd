class_name ColorSwitcher extends Node

@export var sprite: Sprite2D
@export var sprite2: Sprite2D
@export var normal: Color
@export var during: Color
@export var cooldown: Color
@export var is_current_during: bool

func _on_player_movement_state_machine_player_movement_state_changed(state_changed_to: Enums.Player_Movement_State, _state_changed_from: int) -> void:
	if state_changed_to == Enums.Player_Movement_State.DASHING:
		sprite.modulate = during
		sprite2.modulate = during
		is_current_during = true
	elif is_current_during:
		sprite.modulate = cooldown
		sprite2.modulate = cooldown
		is_current_during = false
	else:
		sprite.modulate = normal
		sprite2.modulate = normal
		is_current_during = false
		

func _on_dash_cooldown_timer_timeout() -> void:
	sprite.modulate = normal
	sprite2.modulate = normal
	is_current_during = false
