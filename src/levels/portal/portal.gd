extends Node2D

@onready var collision = $Area2D/CollisionShape2D

var player : CharacterBody2D

func _ready() -> void:
	Global.switch_mask_mode.connect(check_player)

func check_player():
	if player:
		finish_level()

func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	finish_level()

func finish_level():
	if player.is_in_group("Player") and Global.mask_on:
		Global.current_level += 1
		Global.load_transition()


func _on_area_2d_body_exited(_body: Node2D) -> void:
	player = null
	pass
