extends Node

var item_in_hand: Control = null
var current_npc: NpcData = null
var current_money = 30
var exorcism_time: float = 0.0
var items_buyied: Array[ItemData] = []
var pistola = preload("uid://bphvj08yfxe8s")
var selo = preload("uid://d4e5dsh3gijxu")
var items: Array[ItemData] = [pistola, selo]

func is_holding_cross() -> bool:
	return item_in_hand != null and item_in_hand.name == "ItemCross"
	
func is_holding_pistol() -> bool:
	return item_in_hand != null and item_in_hand.name == "Pistol"
	
func is_holding_stamp() -> bool:
	return item_in_hand != null and item_in_hand.name == "Demon_Obssessive_Stamp"
