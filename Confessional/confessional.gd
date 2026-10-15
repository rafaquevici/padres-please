extends CanvasLayer

@export var database: NpcDatabase

var npc: NpcData

@onready var dialogue: Label = $Control/Dialogue
@onready var controlDialogue: int = 0 
@onready var npc_name: Label = $Control/NpcName


func _ready() -> void:
	var generator = NpcGenerator.new(database)
	npc = generator.generate_npc()
	
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
