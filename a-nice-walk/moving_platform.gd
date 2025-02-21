extends AnimatableBody2D


@export var init_velocity: Vector2
var velocity: Vector2
var moving = false
var triggered = false

func move_platform(body: Node2D) -> void:
	if body.is_in_group("Player") and !triggered:
		velocity = init_velocity
		moving = true
		triggered = true


func _physics_process(delta: float) -> void:
	if moving:
		velocity = lerp(velocity, Vector2(0,0), 0.2)
		position += velocity
	
