class_name Character_Animation
extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var name_animation: String
var is_animated: bool

func _ready() -> void:
	if is_animated:
		animated_sprite_2d.play(name_animation)
	else:
		animated_sprite_2d.animation = name_animation
		animated_sprite_2d.frame = 1 
		animated_sprite_2d.stop() 
