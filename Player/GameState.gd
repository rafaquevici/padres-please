extends Node

var item_in_hand: Control = null
var current_npc: NpcData = null

func is_holding_cross() -> bool:
	return item_in_hand != null and item_in_hand.name == "ItemCross"
