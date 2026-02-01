extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(on_body_entered)
	pass # Replace with function body.

func on_body_entered(body: CharacterBody2D):
	if body.is_in_group("Player"):
		Global.sanity_value -= 5
		Global.sanity_changed.emit()
		queue_free()
		pass;
	pass;
