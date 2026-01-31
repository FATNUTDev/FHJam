extends CharacterBody2D

@onready var sanity_timer = $Timer

const SPEED = 150.0
const JUMP_VELOCITY = -250.0
var spikes_collided = false
var prev_direction = 0
 

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
	if direction and !spikes_collided:
		prev_direction = direction
		velocity.x = direction * SPEED
	elif !spikes_collided:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/3)
	if velocity.x == 0:
		spikes_collided = false
		
	move_and_slide()
	pick_mask()
	
	debug_input()

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
	spikes_collided = true
	if velocity.x == 0:
		velocity.x = SPEED*3*prev_direction
	else:
		velocity.x = -velocity.x*3
	velocity.y = -velocity.y

func on_mask_switch_signal():
	#print("player switched")
	pass
	
func on_player_dead_signal():
	#print("Game Over")
	pass

func _on_sanity_timer_timeout() -> void:
	Global.sanity_value += 1
	#print(Global.sanity_value)


func debug_input(): #Use this to debug anything you want, remove the others code down here.
	if Input.is_action_just_pressed("debug"):
		Global.spawn_end_screen()
