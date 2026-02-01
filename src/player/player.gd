extends CharacterBody2D

@onready var sanity_timer = $Timer
@onready var animated_player = $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -200.0
var spikes_collided = false
var prev_direction = 0
var mask = ""
var mask_animation_finished = true
 

func _ready() -> void:
	Global.player_dead.connect(on_player_dead_signal)
	animated_player.animation_finished.connect(on_mask_switched_signal)

func check_player_stats():
	if Global.sanity_value > 99 or Global.player_health <= 0:
		Global.on_player_dead()

func _physics_process(delta: float) -> void:
	#Check Player sanity and health
	check_player_stats()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if mask_animation_finished:
			animated_player.play("jump"+mask)
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
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		if velocity.x < 0 and is_on_floor() and mask_animation_finished:
			if animated_player.flip_h:
				animated_player.flip_h = false
			animated_player.play("walk"+mask)
		elif velocity.x > 0 and is_on_floor() and mask_animation_finished:
			if !animated_player.flip_h:
				animated_player.flip_h = true
			animated_player.play("walk"+mask)
		elif is_on_floor() and mask_animation_finished:
			animated_player.play("idle"+mask)
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/3)
	if velocity.x == 0:
		spikes_collided = false
		
	move_and_slide()
	pick_mask()
	
	debug_input()

func pick_mask():
	if Input.is_action_just_pressed("switch_mask"):
		mask_animation_finished = false
		if !mask:
			animated_player.play("put_mask")
			mask = "mask"
		else:
			animated_player.play_backwards("put_mask")
			mask = ""
		Global.mask_on = !Global.mask_on
		Global.on_mask_switch()
		if Global.mask_on:
			Global.sanity_value += 1
			Global.sanity_changed.emit()
			sanity_timer.start()
		else:
			sanity_timer.stop()

func on_trampoline_collision():
	velocity.y = JUMP_VELOCITY*1.5

func on_spike_collision():
	if !spikes_collided:
		spikes_collided = true
		Global.player_health -= 1
		Global.sanity_value += 5
		Global.sanity_changed.emit()
		Global.player_took_damage.emit()
		if velocity.x == 0:
			velocity.x = -SPEED*3*prev_direction
			#prev_direction = -prev_direction
		else:
			velocity.x = -SPEED*3*prev_direction
		velocity.y = -velocity.y

func on_mask_switched_signal():
	mask_animation_finished = true
	
func on_player_dead_signal():
	#print("Game Over")
	pass

func _on_sanity_timer_timeout() -> void:
	Global.sanity_value += 1
	Global.sanity_changed.emit()
	#print(Global.sanity_value)

func debug_input(): #Use this to debug anything you want, remove the others code down here.
	if Input.is_action_just_pressed("debug"):
		Global.spawn_end_screen()
