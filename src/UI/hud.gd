extends CanvasLayer

@onready var sanity = $Control/sanity
var visible_crit = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# reset to not pop in
	sanity.value = 0
	sanity.tint_over = Color(1,1,1,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sanity.value = Global.sanity_value
	
	# Check to set to cirt enabled
	if (!visible_crit && sanity.value >= 75):
		sanity.tint_over = Color(1,1,1,1)
		visible_crit = true
	
	# check to set to crit disabled (in case we implement healing)
	if (visible_crit && sanity.value < 75):
		sanity.tint_over = Color(1,1,1,0)
		visible_crit = false
	
	pass
