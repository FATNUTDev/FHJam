extends Node2D

@onready var collision = $Area2D/CollisionShape2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.current_level += 1
		Global.load_transition()
