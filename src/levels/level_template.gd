extends Node2D

@onready var mask_on_layer = $MaskOnTileLayer
@onready var mask_off_layer = $MaskOffTileLayer
@onready var second_spikes = $SpikeParent2
@onready var third_spikes = $SpikeParent3
@onready var portal = $Portal

var spikes_2_shown = false;
var spikes_3_shown = false;

func _ready() -> void:
	Global.mask_on = false
	Global.switch_mask_mode.connect(switch_on_mask_signal)
	switch_on_mask_signal()

func _process(delta: float) -> void:
	if (!spikes_2_shown && Global.sanity_value >= 34):
		show_second_spikes()
		spikes_2_shown = true
	if (spikes_3_shown && Global.sanity_value >= 67):
		show_third_spikes()
		spikes_3_shown = false

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
	if (second_spikes && second_spikes.get_child_count() > 0):
		second_spikes.modulate = Color(1,1,1,1)
		second_spikes.process_mode = Node.PROCESS_MODE_INHERIT
	
func show_third_spikes():
	if (third_spikes && third_spikes.get_child_count() > 0):
		third_spikes.modulate = Color(1,1,1,1)
		third_spikes.process_mode = Node.PROCESS_MODE_INHERIT
