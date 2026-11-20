extends Node

@onready var demon_type_obsessive: Control = $"../../UI/Smoke_Container/Demons/DemonTypeObsessive"
@onready var scenario: Control = $"../../UI/Moving_scenario/Scenario"

@export var possessive_demons: Array[DemonData]
@export var obsessive_demons: Array[DemonData]

var current_demon_type: DemonData.DemonType 
var current_demon: DemonData
var is_possessed: bool = true


func _randomize_demon():
	if is_possessed:
		var roll: float = randf()
		current_demon_type = DemonData.DemonType.OBSESSIVE if roll < 1 else DemonData.DemonType.POSSESSIVE
		if current_demon_type == DemonData.DemonType.OBSESSIVE:
			current_demon = obsessive_demons.pick_random()
		else:
			current_demon = possessive_demons.pick_random()
	else:
		current_demon = null
		
func _start_demon():
	if is_possessed:
		if current_demon_type == DemonData.DemonType.OBSESSIVE:
			demon_type_obsessive.visible = true
			demon_type_obsessive._on_set_demon(current_demon)
			demon_type_obsessive._on_set_health(current_demon)
