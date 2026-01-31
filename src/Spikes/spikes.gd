extends Node2D

@onready var animation_pl = $AnimationPlayer
@onready var spike_timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_static_body_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		animation_pl.play_section("up_down", -1, 0.5)
		body.on_spike_collision()
		spike_timer.start()
		

func _on_spike_timer_timeout() -> void:
	spike_timer.stop()
	animation_pl.play_section_backwards("up_down", -1, 0.5)
