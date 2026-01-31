extends CharacterBody2D

@onready var sanity_timer = $Timer

const SPEED = 150.0
const JUMP_VELOCITY = -200.0
 

func _ready() -> void:
	Global.switch_mask_mode.connect(on_mask_switch_signal)
	Global.player_dead.connect(on_player_dead_signal)

func check_player_stats():
	if Global.sanity_value > 99:
		Global.on_player_dead()

func _physics_process(delta: float) -> void:
	#Check Player sanity and health
	check_player_stats()
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
		if Global.mask_on:
			Global.sanity_value += 1
			sanity_timer.start()
		else:
			sanity_timer.stop()

func on_collision():
	pass

func on_mask_switch_signal():
	print("player switched")
	
func on_player_dead_signal():
	print("Game Over")

func _on_sanity_timer_timeout() -> void:
	Global.sanity_value += 1
	print(Global.sanity_value)
