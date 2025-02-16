extends Node2D

func _ready():
	trap_layer.collision_enabled = true
@onready var trap_layer = $TrapLayer
@onready var player = $Player
@onready var anim = $AnimationPlayer



func trap_floor_entered(body: Node2D) -> void:
	if body == player and trap_layer.collision_enabled == true:
		anim.play("trap_floor_disappear")
		
		
	
