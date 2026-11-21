
extends Node

@onready var cursor: TextureRect = $"../../Cursor/Cursor"
@export var cursor_texture: Texture2D

func _ready() -> void:
	var filhos = get_children()

	for i in range(min(filhos.size(), GameState.items_buyied.size())):
		var item: ItemData = GameState.items_buyied[i]
		var filho = filhos[i]

		if filho is Button:
			filho.icon = item.texture
			set_item(item, filho)


func set_item(item: ItemData, filho: Button) -> void:
	filho.set_meta("item", item)

	match item.type:
		ItemData.Type.PISTOL:
			filho.name = "Pistol"

		ItemData.Type.STAMP:
			filho.name = "Stamp"


func free_item(item_type: String) -> void:
	for filho in get_children():
		if filho is Button and filho.name == item_type:

			var item: ItemData = filho.get_meta("item", null)

			if item:
				GameState.items_buyied.erase(item)

			filho.icon = null
			filho.name = "EmptySlot"
			filho.remove_meta("item")
			break

	GameState.item_in_hand = null
	cursor.texture = cursor_texture
