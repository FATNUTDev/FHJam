extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -200.0

func _ready() -> void:
	pass
	#connect("switch_to_mask_mode", on_mask_switch_signal)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	pick_mask()


func pick_mask():
	if Input.is_action_just_pressed("switch_mask"):
		Global.mask_on = !Global.mask_on
		Global.on_mask_switch()

func on_collision():
	pass

func on_mask_switch_signal():
	print("player switched")
