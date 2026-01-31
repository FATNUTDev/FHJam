extends Node

var mask_on := false
signal switch_to_mask_mode

func on_mask_switch():
	print(mask_on)
	switch_to_mask_mode.emit()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
