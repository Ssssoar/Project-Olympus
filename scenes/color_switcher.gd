class_name ColorSwitcher extends Node

@export var sprite: Sprite2D
@export var normal: GradientTexture2D
@export var during: GradientTexture2D
@export var cooldown: GradientTexture2D

func _on_player_movement_state_machine_player_movement_state_changed(state_changed_to: Enums.Player_Movement_State, _state_changed_from: int) -> void:
	if state_changed_to == Enums.Player_Movement_State.DASHING:
		sprite.texture = during
	else:
		sprite.texture = cooldown

func _on_dash_cooldown_timer_timeout() -> void:
	sprite.texture = normal
