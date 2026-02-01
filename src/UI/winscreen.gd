extends Control

@onready var anim_player = $AnimationPlayer

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		Global.back_to_main()
		self.call_deferred("queue_free")
