extends Control

@onready var anim_player = $AnimationPlayer

func fade_in_out():
	anim_player.play("fade_in_out")
	
func emit_global_level_signal():
	Global.emit_level_loading_signal()
