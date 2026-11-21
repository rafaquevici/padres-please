extends Node

@onready var demon_type_obsessive: Control = $"../../UI/Smoke_Container/Demons/DemonTypeObsessive"
@onready var scenario: Control = $"../../UI/Moving_scenario/Scenario"

@export var possessive_demons: Array[DemonData]
@export var obsessive_demons: Array[DemonData]

var is_possessed: bool


func _randomize_demon() -> void:
	if not is_possessed:
		GameState.current_demon = null
		return

	var demons: Array[DemonData]

	var roll := randf()

	if roll < 1:
		demons = obsessive_demons
	else:
		demons = possessive_demons

	if demons.is_empty():
		push_warning("Não existem demônios cadastrados nesse tipo.")
		return

	GameState.current_demon = demons.pick_random()


func _start_demon() -> void:
	var demon: DemonData = GameState.current_demon
	
	if demon == null:
		return

	match demon.demon_type:

		DemonData.DemonType.OBSESSIVE:
			demon_type_obsessive.visible = true
			demon_type_obsessive.setup_demon(demon)

		DemonData.DemonType.POSSESSIVE:
			pass
