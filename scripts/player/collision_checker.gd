class_name PlayerCollisionChecker extends Node

var player: Player

signal collided_with_hazard()

func _physics_process(_delta: float) -> void:
	var coll_ammount = player.get_slide_collision_count()
	for n in coll_ammount:
		var coll = player.get_slide_collision(n)
		var is_hazard = (coll.get_collider() as Node).is_in_group("Hazard")
		if is_hazard:
			collided_with_hazard.emit()
