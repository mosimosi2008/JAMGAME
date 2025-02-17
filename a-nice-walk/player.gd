extends CharacterBody2D


var speed = 300.0
const JUMP_VELOCITY = -400.0
const MAX_SPEED = 600
const  ACC = 75

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x,direction * MAX_SPEED,ACC) # this took an embrassing amount of time
		print(velocity.x) 			
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()
