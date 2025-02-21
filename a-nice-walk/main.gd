extends Node2D

var level_scene = preload("res://level.tscn")
@onready var level = $Level
@onready var skill_check = $SkillCheckLayer/SkillCheck
@onready var skill_check_layer = $SkillCheckLayer
@onready var player = level.player
@onready var check_wall_anim = level.check_wall_anim
@onready var fake_ledge_anim = level.fake_ledge_anim
@onready var piano = level.piano

var skill_check_triggered = false
var ledge_drop_triggered = false
var pausable = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Temp_Reset"):
		reset()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func check_wall_start() -> void:
	if !skill_check_triggered:
		skill_check_layer.visible = true
		skill_check.start()
		level.modulate = "96969696"
		player.actionable = false
		skill_check_triggered = true
		pausable = false


func skill_check_success() -> void:
	skill_check_layer.visible = false
	level.modulate = "ffffff"
	player.actionable = true
	check_wall_anim.play("success")
	pausable = true


func skill_check_fail() -> void:
	skill_check_layer.visible = false
	level.modulate = "ffffff"
	check_wall_anim.play("fall")
	pausable = true


func fake_ledge_drop() -> void:
	if ledge_drop_triggered == false:
		ledge_drop_triggered = true
		level.spring_sprite.play("launch")
		fake_ledge_anim.play("shrink")
	
func reset():
	skill_check_triggered = false
	ledge_drop_triggered = false
	level.queue_free()
	level = level_scene.instantiate()
	add_child(level)
	level.check_wall_start.connect(check_wall_start)
	level.fake_ledge_drop.connect(fake_ledge_drop)
	player = level.player
	check_wall_anim = level.check_wall_anim
	fake_ledge_anim = level.fake_ledge_anim
	piano = level.piano
