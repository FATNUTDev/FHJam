extends Node2D

@onready var collision = $Area2D/CollisionShape2D

func _ready() -> void:
	Global.level_can_be_loaded.connect(add_new_level)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var transition = load("res://src/UI/transition_screen.tscn")
		var transition_instance = transition.instantiate()
		get_tree().get_root().get_node("MAIN/SCREENOVERLAY").call_deferred("add_child",transition_instance)


func add_new_level():
		get_parent().visible = false
		var next_level = Global.current_level + 1
		if FileAccess.file_exists("res://src/levels/level" + str(next_level) + ".tscn"):
			var level_instance = load("res://src/levels/level" + str(next_level) + ".tscn").instantiate()
			Global.return_LEVEL_container().call_deferred("add_child", level_instance)
		else:
			print("No more levels!") #TODO
		remove_this_level()

func remove_this_level():
	Global.current_level += 1
	get_parent().call_deferred("queue_free")
