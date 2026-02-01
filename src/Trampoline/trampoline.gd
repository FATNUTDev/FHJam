extends Node2D

@onready var animation_pl = $AnimationPlayer
var reacted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animation_pl.play("reaction")
		body.on_trampoline_collision()
		reacted = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if reacted:
		animation_pl.play_backwards("reaction")
		reacted = false
