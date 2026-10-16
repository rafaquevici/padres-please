extends CanvasLayer

@export var database: NpcDatabase

var npc: NpcData

@onready var dialogue: Label = $Control/Dialogue
@onready var controlDialogue: int = 0 
@onready var npc_name: Label = $Control/NpcName
const FORGIVE_ATORMENTED_PERSON_1 = preload("uid://brfrok4hw4j3d")
const FORGIVE_DEMON_DIALOGUES_1 = preload("uid://dorycj301yjke")


func _ready() -> void:
	var generator = NpcGenerator.new(database)
	npc = generator.generate_npc()
	GameState.current_npc = npc
	print(npc.name)
	print(npc.possessed)
	
	dialogue.text = npc.dialogue.dialogues[0]
	npc_name.text = npc.name


func _on_talk_more_pressed() -> void:
	if controlDialogue < 2:
		controlDialogue = controlDialogue + 1
		dialogue.text = npc.dialogue.dialogues[controlDialogue]
	else:
		dialogue.text = "..."

func _on_forgive_pressed() -> void:
	if npc.possessed:
		dialogue.text = FORGIVE_DEMON_DIALOGUES_1.dialogues.pick_random()
	else:
		dialogue.text = FORGIVE_ATORMENTED_PERSON_1.dialogues.pick_random()


func _on_exorcism_pressed() -> void:
	get_tree().change_scene_to_file("res://Exorcism/Exorcism.tscn")
