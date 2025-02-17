
extends Area2D

func _on_body_entered(body):
	print('you died')
	get_tree().paused = true
