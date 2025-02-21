extends CharacterBody2D



var gravity = 50

const FALL_SPEED = 500
const JUMP_VELOCITY = -800.0
var MAX_SPEED = 300
const  ACC = 75
const MAX_COYOTE_TIME = 0.05
var coyote_time = 0
var actionable = true
var temp_velocity: Vector2
var additive_velocity = Vector2(0,0)

@onready var player_anim = $PlayerAnim
@onready var wind_box = $"../WindBox"

func _physics_process(delta: float) -> void:
	if wind_box.overlaps_body(self):
		additive_velocity.x = -400
		MAX_SPEED = 500
	else:
		additive_velocity.x = 0
		MAX_SPEED = 300
	
	if actionable:
		# Add the gravity.
		if not is_on_floor():
			temp_velocity.y = move_toward(temp_velocity.y, FALL_SPEED, gravity*delta)
			coyote_time = move_toward(coyote_time, 0, delta)
		elif coyote_time != MAX_COYOTE_TIME:
			coyote_time = MAX_COYOTE_TIME
		
		if velocity.y < 0:
			gravity = 3000
		else:
			gravity = 1000
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and coyote_time > 0:
			temp_velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("ui_left", "ui_right")
		if direction:
			temp_velocity.x = move_toward(temp_velocity.x,direction * MAX_SPEED,ACC) # this took an embrassing amount of time	
		else:
			temp_velocity.x = move_toward(temp_velocity.x, 0, ACC)
		velocity = temp_velocity + additive_velocity
		move_and_slide()

func screen_shake():
	player_anim.play("screen_shake")
	


func spring(body: Node2D) -> void:
	if body == self:
		$"../Spring/SpringSprite".play("launch")

		temp_velocity.y = -10000


func peel_slip(body: Node2D) -> void:
	if body == self:
		actionable = false
		$"../BananaPeel/AnimatedSprite2D".frame = 1
		player_anim.play("slip")
