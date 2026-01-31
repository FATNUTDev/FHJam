extends CanvasLayer

@onready var sanity = $Control/sanity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sanity.texture_over.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
