extends Node2D

@onready var mask_on_layer = $MaskOnTileLayer
@onready var mask_off_layer = $MaskOffTileLayer

func _ready() -> void:
	Global.switch_mask_mode.connect(switch_on_mask_signal)

func switch_on_mask_signal():
	mask_on_layer.collision_enabled = Global.mask_on
	if Global.mask_on: #TODO
		mask_on_layer.modulate = Color(1,0.3,0.3,1)
	else:
		mask_on_layer.modulate = Color(1,1,1.7,.3)
