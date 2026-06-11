class_name BreakEffect extends Node
@export var base_node: Node


func _on_bounce_ground_struck() -> void:
	base_node.queue_free()
