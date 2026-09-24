class_name NpcData
extends RefCounted

var name: String
var possessed: bool
var dialogue: DialogueBlock


func Initiate_Name(nome: String):
	name = nome


func Initiate_Possessed(valor: bool):
	possessed = valor


func Initiate_Dialogue(bloco: DialogueBlock):
	dialogue = bloco
