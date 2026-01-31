extends Control

@onready var anim_player = $AnimationPlayer

func fade_in_out():
	anim_player.play("fade_in_out")

func load_level_Global():
	Global.load_level()
