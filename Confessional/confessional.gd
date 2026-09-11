extends CanvasLayer

@export var Npc1: NpcData
@onready var dialogue: Label = $Control/Dialogue
@onready var controlDialogue: int = 0 
@onready var npc_name: Label = $Control/NpcName



func _ready() -> void:
	dialogue.text = Npc1.Dialogues[0]
	npc_name.text = Npc1.name



func _on_talk_more_pressed() -> void:
	if controlDialogue + 1 < Npc1.Dialogues.size():
		controlDialogue += 1
		dialogue.text = Npc1.Dialogues[controlDialogue]
	else:
		controlDialogue = controlDialogue - (controlDialogue - 1)
		dialogue.text = Npc1.Dialogues[controlDialogue]
		
