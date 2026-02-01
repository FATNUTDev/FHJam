extends Node

signal switch_mask_mode
signal player_took_damage
signal player_dead
signal level_can_be_loaded

var mask_on := false
var sanity_value := 0 #Max 100
var current_level := 1
var player_health := 6#TBD

func on_mask_switch():
	switch_mask_mode.emit()

func on_player_dead():
	player_dead.emit()
	spawn_end_screen()


func return_MENU_container():
	return get_tree().get_root().get_node("MAIN/MENU")
func return_LEVEL_container():
	return get_tree().get_root().get_node("MAIN/LEVEL")
func return_SCREENLAYER_container():
	return get_tree().get_root().get_node("MAIN/SCREENLAYER")


func restart_level():
	var level_container = get_tree().get_root().get_node("MAIN/LEVEL")
	var level_child = level_container.get_child(0)
	level_container.remove_child(level_child)
	var new_level = load("res://src/levels/level" + str(current_level) + ".tscn")
	var new_level_instance = new_level.instantiate()
	level_container.add_child(new_level_instance)

func load_transition():
	var transition = load("res://src/UI/transition_screen.tscn")
	var transition_instance = transition.instantiate()
	get_tree().get_root().get_node("MAIN/SCREENOVERLAY").call_deferred("add_child",transition_instance)

func load_level():
	remove_level()
	if !FileAccess.file_exists("res://src/levels/level"+ str(current_level) + ".tscn"):
		return
	var level = load("res://src/levels/level"+ str(current_level) + ".tscn")
	var level_instance = level.instantiate()
	get_tree().get_root().get_node("MAIN/LEVEL").call_deferred("add_child",level_instance)
	
func remove_level():
	if !get_tree().get_root().get_node("MAIN/LEVEL").get_child_count() > 0:
		return
	var level_to_delete = get_tree().get_root().get_node("MAIN/LEVEL").get_child(0)
	get_tree().get_root().get_node("MAIN/LEVEL").call_deferred("remove_child",level_to_delete)
	
func spawn_end_screen():
	var end_screen = load("res://src/UI/end_screen_root.tscn")
	var end_screen_instance = end_screen.instantiate()
	get_tree().get_root().get_node("MAIN/ENDOVERLAY").call_deferred("add_child",end_screen_instance)
