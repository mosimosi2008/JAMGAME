extends Node2D

signal piano_crash
var velocity = 0
var timer_running = false
const MAX_TIMER = 1
var timer = MAX_TIMER
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += velocity
	if timer_running:
		timer-=delta
		if timer == 0:
			velocity = 0
			timer_running = false


func hit_player(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#Add sound bite before emit
		piano_crash.emit()

func start_falling(body):
	if body.is_in_group("Player"):
		velocity = 5
		timer_running = true
		#start piano music
