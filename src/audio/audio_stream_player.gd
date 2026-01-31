extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.switch_mask_mode.connect(handle_switch)
	pass # Replace with function body.

func handle_switch() ->void:
	if (Global.mask_on):
		self.bus = "Distorted"
	else:
		self.bus = "EQ-Low_Reducer"
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
