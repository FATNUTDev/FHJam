extends Node

signal switch_mask_mode
signal player_took_damage
signal player_dead


var mask_on := false
var sanity_value := 0 #Max 100
var current_level := 0
var player_health := 6#TBD


func on_mask_switch():
	print(mask_on) #TODO
	switch_mask_mode.emit()

func on_player_dead():
	player_dead.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
