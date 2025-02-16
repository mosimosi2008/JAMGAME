extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const COYOTE_TIME_MAX = 0.1
var coyote_time = 0.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		coyote_time = move_toward(coyote_time, 0, delta)
	elif coyote_time!=COYOTE_TIME_MAX:
		coyote_time = COYOTE_TIME_MAX
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and coyote_time > 0:
		velocity.y = JUMP_VELOCITY
		coyote_time = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
