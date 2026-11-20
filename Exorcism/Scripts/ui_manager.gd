extends Node

@onready var cursor: TextureRect = $Cursor/Cursor
@onready var item_cross: Button = $Moving_scenario/Fixed_items/ItemCross
@export var closed_hand: Texture2D
@onready var demon_catalog: Control = $Moving_scenario/Catalog/DemonCatalog
@onready var catalog_button: Button = $Moving_scenario/Buttons/CatalogButton
@onready var exorcism: Exorcism = $".."


func _define_cursor():
	if cursor.texture == closed_hand:
		cursor.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	else:
		cursor.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
func _open_catalog():
	if GameState.item_in_hand == item_cross:
		pass
	else:
		demon_catalog.visible = true
		catalog_button.visible = false
	
func _on_catalog_visibility_changed():
	catalog_button.visible = true
	
func open_store():
	get_tree().change_scene_to_file("res://Store/Store.tscn")
	
	
