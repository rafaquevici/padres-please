extends Node

@onready var moving_scenario: Control = $"../../UI/Moving_scenario"

var animation_scene = preload("res://Animations/Characters.tscn")

func _get_character(name: String, is_animated_p: bool):
	var new_character = animation_scene.instantiate()

	new_character.name_animation = name
	new_character.is_animated = is_animated_p
	new_character.z_index = -1

	GameState.current_character = new_character

	new_character.get_node("Area2D").input_event.connect(_on_character_input)

	moving_scenario.add_child(new_character)


func _on_character_input(
	viewport: Node,
	event: InputEvent,
	shape_idx: int
) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		GameState.finish_game(GameState.endings.HUMAN)
