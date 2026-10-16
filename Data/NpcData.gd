class_name NpcData
extends RefCounted

var name: String
var possessed: bool
var dialogue: DialogueBlock
var sprite: Texture2D


func Initiate_Name(nameChosen: String):
	name = nameChosen


func Initiate_Possessed(value: bool):
	possessed = value


func Initiate_Dialogue(dialogueBlock: DialogueBlock):
	dialogue = dialogueBlock


func Initiate_Sprite(spriteChoosen: Texture2D):
	sprite = spriteChoosen
