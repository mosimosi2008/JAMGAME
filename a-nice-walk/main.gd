extends Node2D

@onready var level = $Level
@onready var skill_check = $SkillCheckLayer/SkillCheck
@onready var skill_check_layer = $SkillCheckLayer
@onready var player = $Level/Player
@onready var check_wall_anim = $Level/CheckWall/CheckWallAnim
@onready var fake_ledge_anim = $Level/FakeLedge/FakeLedgeAnim

var skill_check_triggered = false
var ledge_drop_triggered = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func check_wall_start(body: Node2D) -> void:
	if body == player and !skill_check_triggered:
		skill_check_layer.visible = true
		skill_check.start()
		level.modulate = "96969696"
		player.actionable = false
		skill_check_triggered = true


func skill_check_success() -> void:
	skill_check_layer.visible = false
	level.modulate = "ffffff"
	player.actionable = true
	check_wall_anim.play("success")


func skill_check_fail() -> void:
	skill_check_layer.visible = false
	level.modulate = "ffffff"
	check_wall_anim.play("fall")


func fake_ledge_drop(body: Node2D) -> void:
	if body == player and ledge_drop_triggered == false:
		ledge_drop_triggered = true
		fake_ledge_anim.play("shrink")
	
