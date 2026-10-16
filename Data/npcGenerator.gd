class_name NpcGenerator
extends RefCounted

var database: NpcDatabase

@warning_ignore("shadowed_variable")
func _init(database: NpcDatabase):
	self.database = database

func generate_Sprites() -> Texture2D:
	return database.sprites.pick_random()

func generate_names() -> String:
	return database.name.pick_random()

func generate_possessed() -> bool:
	return randi_range(0, 1) == 1

var possessed = generate_possessed()

@warning_ignore("shadowed_variable")
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
	npc.Initiate_Sprite(generate_Sprites())
	return npc
