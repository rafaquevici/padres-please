extends Node

@onready var cursor: TextureRect = $"../../Cursor/Cursor"
@export var cursor_texture: Texture2D

func _ready() -> void:
	var filhos = get_children()

	for i in range(min(filhos.size(), GameState.items_buyied.size())):
		var item: ItemData = GameState.items_buyied[i]
		filhos[i].icon = item.texture
		set_item(item, filhos[i])


func set_item(item: ItemData, filho: Button) -> void:
	if item.name == "Pistola":
		filho.name = "Pistol"
	elif item.name == "Selo Demônio Obsessivo":
		filho.name = "Demon_Obssessive_Stamp"
		
func free_item(item_name: String) -> void:
	for filho in get_children():
		if filho is Button and filho.name == item_name:
			var item: ItemData = filho.get_meta("item", null)
			if item:
				GameState.items_buyied.erase(item)
			filho.icon = null
			filho.name = "EmptySlot"
			break
	cursor.texture = cursor_texture
