extends Node2D

@onready var collision = $Area2D/CollisionShape2D
var closed = false

var player : CharacterBody2D

func _ready() -> void:
	Global.switch_mask_mode.connect(check_player)

func check_player():
	if player:
		finish_level()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		finish_level()

func _ready() -> void:
	var key = get_parent().get_node("KeyArea")
	if key:
		closed = true
	pass
	
func open_portal():
	closed = false

func finish_level():
	if player.is_in_group("Player") and Global.mask_on:
		if closed: return
		Global.current_level += 1
		Global.load_transition()


func _on_area_2d_body_exited(_body: Node2D) -> void:
	player = null
	pass
