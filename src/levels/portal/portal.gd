extends Node2D

@onready var collision = $Area2D/CollisionShape2D
var closed = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if closed: return

		Global.current_level += 1
		Global.load_transition()

func _ready() -> void:
	var key = get_parent().get_node("KeyArea")
	if key:
		closed = true
	pass
	
func open_portal():
	closed =false
