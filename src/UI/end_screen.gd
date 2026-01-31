extends Control

@onready var anim_player = $AnimationPlayer

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		Global.restart_level()
		self.queue_free()
