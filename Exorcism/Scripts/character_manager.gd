extends Node

@onready var moving_scenario: Control = $"../UI/Moving_scenario"


var animation_scene = preload("res://Animations/Characters.tscn")


func _get_character(name: String, is_animated_p: bool):
	var new_character = animation_scene.instantiate()
	new_character.name_animation = name
	new_character.is_animated = is_animated_p
	new_character.z_index = -1
	moving_scenario.add_child(new_character)
