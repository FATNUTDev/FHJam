extends Control


func _on_play_button_pressed() -> void:
	Global.load_transition()
	await get_tree().create_timer(1).timeout
	self.queue_free()

func _on_quit_button_pressed() -> void: 
	get_tree().quit()
