class_name PickReactor extends Node


func _on_pick_area_l_body_entered(body: Node2D) -> void:
	on_pick_area_entered(body)


func _on_pick_area_r_body_entered(body: Node2D) -> void:
	on_pick_area_entered(body)

func on_pick_area_entered(body: Node2D) -> void:
	if body is Ground:
		body.strike()
