extends Node2D

func _ready():
	trap_layer.collision_enabled = true
@onready var trap_layer = $TrapLayer
@onready var player = $Player




func trap_floor_entered(body: Node2D) -> void:
	if body == player:
		trap_layer.collision_enabled = false
		trap_layer.visible = false
