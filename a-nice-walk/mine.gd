extends Node2D

signal mine_triggered
signal mine_kill
@onready var mine_anim = $AnimationPlayer


func triggered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		mine_anim.play("Explode")
		mine_triggered.emit()
#
func kill():
	mine_kill.emit()
