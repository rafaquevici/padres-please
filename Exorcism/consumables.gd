extends Node

func _ready() -> void:
	var filhos = get_children()

	for i in range(min(filhos.size(), GameState.items_buyied.size())):
		filhos[i].icon = GameState.items_buyied[i].texture
