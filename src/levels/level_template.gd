extends Node2D

@onready var mask_on_layer = $MaskOnTileLayer
@onready var mask_off_layer = $MaskOffTileLayer
@onready var second_spikes = $SpikeParent2
@onready var third_spikes = $SpikeParent3
@onready var portal = $Portal

func _ready() -> void:
	Global.switch_mask_mode.connect(switch_on_mask_signal)
	switch_on_mask_signal()

func _process(delta: float) -> void:
	if Global.sanity_value >= 34:
		show_second_spikes()
	if Global.sanity_value >= 67:
		show_third_spikes()

func switch_on_mask_signal():
	mask_on_layer.collision_enabled = Global.mask_on
	mask_off_layer.collision_enabled = !Global.mask_on
	portal.visible = Global.mask_on
	
	if Global.mask_on: #TODO
		mask_on_layer.modulate = Color(1,0.3,0.3,1)
		mask_off_layer.modulate = Color(0.3,0.3,1,1)
	else:
		mask_on_layer.modulate = Color(1,0.3,0.3,0)
		mask_off_layer.modulate = Color(1,1,1,1)

func show_second_spikes():
	second_spikes.modulate = Color(1,1,1,1)
	second_spikes.process_mode = Node.PROCESS_MODE_INHERIT
	
func show_third_spikes():
	third_spikes.modulate = Color(1,1,1,1)
	third_spikes.process_mode = Node.PROCESS_MODE_INHERIT
