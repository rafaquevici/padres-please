class_name Exorcism
extends Control

@onready var ir_loja: Button = $UI/ir_loja
@onready var cronometro: Node = $Cronometro
@onready var demon_type_obsessive: Control = $Demon_manager/DemonTypeObsessive
@onready var catalog_button: Button = $UI/Moving_scenario/Z2/Buttons/CatalogButton
@onready var demon_catalog: Control = $UI/DemonCatalog
@onready var item_cross: Button = $UI/Moving_scenario/Z2/Fixed_items/ItemCross
@onready var incensary: Button = $UI/Moving_scenario/Z2/Fixed_items/Incensary
@onready var cursor: TextureRect = $UI/Cursor/Cursor
@onready var scenario: Control = $UI/Moving_scenario
@onready var item_exorcism_manager: Node = $Item_exorcism_manager
@onready var sound_manager: Node = $Sound_manager
@onready var character_manager: Node = $Character_manager
@onready var ui: Node = $UI
@onready var demon_manager: Node = $Demon_manager


var money_acquired: float


func _ready():
	sound_manager.play_music(true)
	character_manager._get_character("genova", true)
	GameState.exorcism_time = 0.0
	cronometro.counting = true
	randomize()
	demon_manager._randomize_demon()
	demon_manager._start_demon()
	ui._define_cursor()
	demon_type_obsessive.died.connect(end_exorcism)
	catalog_button.pressed.connect(ui._open_catalog)
	demon_catalog.not_visible.connect(ui._on_catalog_visibility_changed)
	item_cross.pressed.connect(item_exorcism_manager._on_item_cross_pressed)
	incensary.pressed.connect(item_exorcism_manager._on_item_incencary_pressed)
	ir_loja.pressed.connect(open_store)

func _process(delta: float):
	var velocidade: float = 100.0
	var mouse_pos: Vector2 = get_global_mouse_position()
	var window_size = DisplayServer.window_get_size()
	var half_size: Vector2 = cursor.size / 2.0
	cursor.global_position = mouse_pos - half_size
	if mouse_pos.y > (window_size.y - 10) and scenario.position.y > -250:
		scenario.position.y -= velocidade * delta
		if 	demon_type_obsessive:
			demon_type_obsessive.position.y -= velocidade * delta
	elif mouse_pos.y < 10 and scenario.position.y < 250:
		scenario.position.y += velocidade * delta
		if 	demon_type_obsessive:
			demon_type_obsessive.position.y += velocidade * delta
		

func end_exorcism():
	cronometro.counting = false
	money_acquired = 10 - (GameState.exorcism_time * 0.001)
	GameState.current_money += money_acquired
	sound_manager.play_music(false)

func open_store():
	get_tree().change_scene_to_file("res://Store/Store.tscn")
