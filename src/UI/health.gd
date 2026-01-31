extends Control
@onready var fst = $"HBoxContainer/1-2"
@onready var snd = $"HBoxContainer/3-4"
@onready var last = $"HBoxContainer/5-6"

var i_full = Image.load_from_file("res://src/assets/hp/full.png")
var full = ImageTexture.create_from_image(i_full)
var i_half = Image.load_from_file("res://src/assets/hp/half.png")
var half = ImageTexture.create_from_image(i_half)
var i_empty = Image.load_from_file("res://src/assets/hp/empty.png")
var empty = ImageTexture.create_from_image(i_empty)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.player_took_damage.connect(handle_dmg)
	handle_dmg()
	pass # Replace with function body.

func handle_dmg() -> void:
	var hp = Global.player_health
	if (hp > 1):
		fst.texture = full
	if (hp > 3):
		snd.texture = full
	if (hp > 5):
		last.texture = full
	if (hp < 5):
		last.texture = empty
	if (hp < 3):
		snd.texture = empty
	if (hp < 1):
		fst.texture = empty
	if (hp == 1):
		fst.texture = half
	if (hp == 3):
		snd.texture = half
	if (hp == 5):
		last.texture = half
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
