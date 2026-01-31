extends CharacterBody2D

@onready var sanity_timer = $Timer

const SPEED = 150.0
const JUMP_VELOCITY = -275.0
var spikes_collided = false
var prev_direction = 0
 

func _ready() -> void:
	Global.switch_mask_mode.connect(on_mask_switch_signal)
	Global.player_dead.connect(on_player_dead_signal)

func check_player_stats():
	if Global.sanity_value > 99 or Global.player_health <= 0:
		Global.on_player_dead()

func _physics_process(delta: float) -> void:
	#Check Player sanity and health
	check_player_stats()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if !spikes_collided:
		# Handle jump.
		if Input.is_action_just_pressed("ui_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:# and !spikes_collided:
			prev_direction = direction
			velocity.x = direction * SPEED
		#elif !spikes_collided:
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED/3)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/3)
	if velocity.x == 0:
		spikes_collided = false
		

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

func on_spike_collision():
	if !spikes_collided:
		spikes_collided = true
		Global.player_health -= 1
		Global.sanity_value += 5
		Global.player_took_damage.emit()
		if velocity.x == 0:
			velocity.x = -SPEED*3*prev_direction
			#prev_direction = -prev_direction
		else:
			velocity.x = -SPEED*3*prev_direction
		velocity.y = -velocity.y

func on_mask_switch_signal():
	print("player switched")
	
func on_player_dead_signal():
	print("Game Over")

func _on_sanity_timer_timeout() -> void:
	Global.sanity_value += 1
	print(Global.sanity_value)
