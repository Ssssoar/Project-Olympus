class_name SpriteSwitcher extends Node

@export var player: CharacterBody2D
@export var air_sprite: Sprite2D
@export var ground_sprite: Sprite2D

func _process(_delta: float) -> void:
	if player.is_on_floor():
		ground_sprite.show()
		air_sprite.hide()
	else:
		ground_sprite.hide()
		air_sprite.show()
