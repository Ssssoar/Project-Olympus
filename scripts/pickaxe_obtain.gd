class_name DashPickup extends Area2D

@export var appearer: Node2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		(body as Player).can_dash = true
		self.queue_free()
		appearer.show()
