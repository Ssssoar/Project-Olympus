class_name GameOverHandler extends Node

@export var particle: PackedScene
@export var timer: Timer

var player: Player
var triggered: bool

func trigger_game_over():
	if triggered: return
	triggered = true
	var instantiated = particle.instantiate() as Node2D
	player.get_parent().add_child(instantiated)
	instantiated.position = player.position
	(instantiated as GPUParticles2D). emitting = true
	player.hide()
	timer.start()

func _on_collision_checker_collided_with_hazard() -> void:
	trigger_game_over()

func _on_game_over_timer_timeout() -> void:
	LevelLoader.reload_scene()
