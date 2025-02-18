extends Control

signal skill_check_success
signal skill_check_fail

var keys = [
	"ui_up",
	"ui_up",
	"ui_down",
	"ui_down",
	"ui_left",
	"ui_right",
	"ui_left",
	"ui_right",
	"b",
	"a",
	"ui_accept"
]

@onready var sprite_keys = [
	$Sprite2D,
	$Sprite2D2,
	$Sprite2D3,
	$Sprite2D4,
	$Sprite2D8,
	$Sprite2D9,
	$Sprite2D10,
	$Sprite2D11,
	$Sprite2D5,
	$Sprite2D6,
	$Sprite2D7,
]
var i = 0

var started = false
var failed = false
const MAX_TIMER = 7
var timer = MAX_TIMER
@onready var timer_label = $TimerLabel

# Called when the node enters the scene tree for the first time.
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(keys[i]) and started:
		if 9>i:
			sprite_keys[i+2].appear()
		sprite_keys[i].vanish()
		if i == 10:
			success()
		i = move_toward(i, 10, 1)

		
	
func _ready() -> void:
	pass

func start():
	started = true
	sprite_keys[0].appear()
	sprite_keys[1].delayed_appear()
	i = 0
	timer = MAX_TIMER
# Called every frame. 'delta' is the elapsed time since the previous frame.
func success():
	started = false
	skill_check_success.emit()

func _process(delta: float) -> void:
	if started:
		timer = move_toward(timer, 0, delta)
		timer_label.text = str(roundf(timer))
		if timer == 0:
			if !failed:
				skill_check_fail.emit()
				failed = true
	
