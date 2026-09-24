class_name NpcGenerator
extends RefCounted

var database: NpcDatabase

func _init(database: NpcDatabase):
	self.database = database


func generate_names() -> String:
	return database.Name.pick_random()

func generate_possessed() -> bool:
	return randi_range(0, 1) == 1

var possessed = generate_possessed()

func generate_dialogues(possessed: bool) -> DialogueBlock:
	if (possessed):
		return database.possessedDialogue.pick_random()
	else:
		return database.normalDialogue.pick_random() 

func generate_npc() -> NpcData:
	
	var npc = NpcData.new()
	
	npc.Initiate_Name(generate_names()) 
	npc.Initiate_Possessed(generate_possessed())
	npc.Initiate_Dialogue(generate_dialogues(npc.possessed))
	return npc
