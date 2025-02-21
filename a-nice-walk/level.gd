extends Node2D

signal fake_ledge_drop
signal check_wall_start
signal level_success

func _ready():
	trap_layer.collision_enabled = true
@onready var trap_layer = $TrapLayer
@onready var player = $Player
@onready var anim = $AnimationPlayer
@onready var fake_flag_sprite = $FakeFlag
@onready var fake_flag_anim = $FakeFlag/FakeFlagAnim
@onready var check_wall_anim = $CheckWall/CheckWallAnim
@onready var fake_ledge_anim = $FakeLedge/FakeLedgeAnim
@onready var piano = $Piano
@onready var spring_sprite = $Spring/SpringSprite
@onready var end_checkpoint = $EndCheckpoint
@onready var end_checkpoint_anim = $EndCheckpoint/EndCheckpointAnim

func trap_floor_entered(body: Node2D) -> void:
	if body == player and trap_layer.collision_enabled == true:
		anim.play("trap_floor_disappear")
		

func kill_zone_entered(body: Node2D) -> void:
	if body == player:
		kill_player()
		
func kill_player():
	player.actionable = false
	
	

func mine_connect():
	player.actionable = false

func mine_kill():
	player.player_anim.play("screen_shake")
	kill_player()


func fake_flag_enter(body: Node2D) -> void:
	if body == player:
		fake_flag_sprite.animation = "fake"


func fake_flag_exited(body: Node2D) -> void:
	if body == player:
		fake_flag_sprite.animation = "real"


func fake_flag_triggered(body: Node2D) -> void:
	if body == player:
		player.actionable = false
		fake_flag_anim.play("fake_flag_triggered")

func fake_ledge(body: Node2D) -> void:
	if body == player:
		fake_ledge_drop.emit()
	

func start_check_wall(body: Node2D) -> void:
	if body == player:
		check_wall_start.emit()

var i = 0
func end_checkpoint_entered(body: Node2D):
	if body == player:
		if i == 0:
			end_checkpoint_anim.play("first_move")
		elif i == 1:
			end_checkpoint_anim.play("second_move")
		elif i == 2:
			level_success.emit()
			player.actionable = false
		i+=1
