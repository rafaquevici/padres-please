class_name Exorcism
extends Control

@onready var confessional: Button = $UI/Moving_scenario/Buttons/Confessional
@onready var cronometro: Node = $Cronometro
@onready var demon_type_obsessive: Control = $UI/Smoke_Container/Demons/DemonTypeObsessive
@onready var catalog_button: Button = $UI/Moving_scenario/Buttons/CatalogButton
@onready var demon_catalog: Control = $UI/Moving_scenario/Catalog/DemonCatalog
@onready var item_cross: Button = $UI/Moving_scenario/Fixed_items/ItemCross
@onready var incensary: Button = $UI/Moving_scenario/Fixed_items/Incensary
@onready var cursor: TextureRect = $UI/Cursor/Cursor
@onready var scenario: Control = $UI/Moving_scenario
@onready var ui: Control = $UI
@onready var item_exorcism_manager: Control = $Managers/Item_exorcism_manager
@onready var sound_manager: Control = $Managers/Sound_manager
@onready var character_manager: Control = $Managers/Character_manager
@onready var demon_manager: Control = $Managers/Demon_manager
@onready var smoke_container: CanvasLayer = $UI/Smoke_Container
@onready var consumables: Control = $UI/Moving_scenario/Consumables



var money_acquired: float


func _ready():
	demon_manager.is_possessed = GameState.current_npc.possessed
	print(GameState.current_npc.possessed)
	sound_manager.play_music(true)
	character_manager._get_character(GameState.current_npc.sprite, true)
	GameState.exorcism_time = 0.0
	cronometro.counting = true
	randomize()
	demon_manager._randomize_demon()
	demon_manager._start_demon()
	ui._define_cursor()
	demon_type_obsessive.died.connect(end_exorcism)
	catalog_button.pressed.connect(ui._open_catalog)
	demon_catalog.not_visible.connect(ui._on_catalog_visibility_changed)
	for button in consumables.get_children():
		if button is Button:
			button.pressed.connect(item_exorcism_manager._on_consumable_pressed.bind(button))
	item_cross.pressed.connect(item_exorcism_manager._on_item_cross_pressed)
	incensary.pressed.connect(item_exorcism_manager._on_item_incencary_pressed)
	confessional.pressed.connect(open_confessional)

func _process(delta: float):
	var velocidade: float = 100.0
	var mouse_pos: Vector2 = get_global_mouse_position()
	var viewport_size: Vector2 = get_viewport_rect().size
	var half_size: Vector2 = cursor.size / 2.0
	cursor.global_position = mouse_pos - half_size
	if mouse_pos.y > (viewport_size.y - 10) and scenario.position.y > -250:
		scenario.position.y -= velocidade * delta
		smoke_container.offset.y -= velocidade * delta
	elif mouse_pos.y < 10 and scenario.position.y < 250:
		scenario.position.y += velocidade * delta
		smoke_container.offset.y += velocidade * delta
		

func _input(event: InputEvent) -> void:
	if not (event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed):
		return

	var hovered = get_viewport().gui_get_hovered_control()

	if hovered is Button and (
		hovered.get_parent() == consumables
		or hovered == item_cross
		or hovered == incensary
	):
		return

	elif GameState.is_holding_stamp():
		if GameState.current_demon != null \
		and GameState.current_demon.demon_type == DemonData.DemonType.OBSESSIVE:
			consumables.free_item("Stamp")
			GameState.current_demon.kill()
							

func end_exorcism():
	cronometro.counting = false
	money_acquired = snappedf(10.0 - (GameState.exorcism_time * 0.001), 1)
	money_acquired = int(money_acquired)
	GameState.current_money += money_acquired
	print(GameState.current_money)
	sound_manager.play_music(false)
	open_confessional()

func open_confessional():
	get_tree().change_scene_to_file("res://Confessional/confessional.tscn")
	
func used_pistol():
		if GameState.is_holding_pistol():
			consumables.free_item("Pistol")
			GameState.items.remove_at(0)
