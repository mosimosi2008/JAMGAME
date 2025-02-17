extends CharacterBody2D



var gravity = 50

const FALL_SPEED = 500
const JUMP_VELOCITY = -800.0
const MAX_SPEED = 300
const  ACC = 75
const MAX_COYOTE_TIME = 0.1
var coyote_time = 0
var actionable = true

func _physics_process(delta: float) -> void:
	if actionable:
		# Add the gravity.
		if not is_on_floor():
			velocity.y = move_toward(velocity.y, FALL_SPEED, gravity*delta)
			coyote_time = move_toward(coyote_time, 0, delta)
		elif coyote_time != MAX_COYOTE_TIME:
			coyote_time = MAX_COYOTE_TIME
		
		if velocity.y < 0:
			gravity = 3000
		else:
			gravity = 1000
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and coyote_time > 0:
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = move_toward(velocity.x,direction * MAX_SPEED,ACC) # this took an embrassing amount of time	
		else:
			velocity.x = move_toward(velocity.x, 0, ACC)

		move_and_slide()
