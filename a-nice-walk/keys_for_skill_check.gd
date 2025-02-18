extends Sprite2D

@onready var key_sprite_anim = $KeySpriteAnim

func appear():
	key_sprite_anim.play("appear")
	
func vanish():
	key_sprite_anim.play("vanish")

func delayed_appear():
	key_sprite_anim.play("delayed_appear")
