extends Control


func _on_play_button_pressed() -> void:
	spawn_transition()

func _ready() -> void:
	Global.level_can_be_loaded.connect(spawn_level_1)

func _on_quit_button_pressed() -> void: 
	get_tree().quit()

func spawn_transition():
	var transition = load("res://src/UI/transition_screen.tscn")
	var transition_instance = transition.instantiate()
	get_tree().get_root().get_node("MAIN/SCREENOVERLAY").call_deferred("add_child",transition_instance)

func spawn_level_1():
	self.visible = false
	var level1 = load("res://src/levels/level1.tscn")
	var level1_instance = level1.instantiate()
	get_tree().get_root().get_node("MAIN/LEVEL").call_deferred("add_child",level1_instance)
