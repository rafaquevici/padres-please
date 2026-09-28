class_name Exorcism
extends Control

# Filhos cena
@onready var catalog_button: Button = $CatalogButton
@onready var demon_catalog: Control = $DemonCatalog
@onready var cursor: TextureRect = $Cursor
@onready var item_cross: Button = $ItemContainer1/ItemCross
@onready var demon_type_obsessive: Control = $Demons/DemonTypeObsessive
@onready var holding_cursor: TextureRect = $HoldingCursor


@export var possessive_demons: Array[DemonData]
@export var obsessive_demons: Array[DemonData]
@export var open_hand: Texture2D
@export var closed_hand: Texture2D

var current_demon_type: DemonData.DemonType 
var current_demon: DemonData
var is_possessed: bool = false

func _ready():
	randomize()
	_check_possession()
	_randomize_demon()
	_start_demon()
	catalog_button.pressed.connect(_open_catalog)
	demon_catalog.not_visible.connect(_on_catalog_visibility_changed)
	item_cross.pressed.connect(_on_item_cross_pressed)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	
func _process(delta: float):
	var mouse_pos: Vector2 = get_global_mouse_position()
	var half_size: Vector2 = holding_cursor.size / 2.0
	holding_cursor.global_position = mouse_pos - half_size
	cursor.global_position = mouse_pos - half_size
	
	
func _on_item_cross_pressed():
	if item_cross.icon != null:
		holding_cursor.texture = item_cross.icon
		cursor.texture = open_hand
		item_cross.icon = null
		GameState.item_in_hand = item_cross
	else:
		item_cross.icon = holding_cursor.texture
		holding_cursor.texture = null
		GameState.item_in_hand = null
		cursor.texture = closed_hand
	
func _randomize_demon():
	if is_possessed:
		var roll: float = randf()
		current_demon_type = DemonData.DemonType.OBSESSIVE if roll < 0.7 else DemonData.DemonType.POSSESSIVE
		if current_demon_type == DemonData.DemonType.OBSESSIVE:
			current_demon = obsessive_demons.pick_random()
		else:
			current_demon = possessive_demons.pick_random()
	else:
		current_demon = null
	
func _open_catalog():
	demon_catalog.visible = true
	catalog_button.visible = false
	
func _on_catalog_visibility_changed():
	catalog_button.visible = true

func _check_possession() -> void:
	if randf() < 0.5:
		is_possessed = true
	else:
		is_possessed = false

func _start_demon():
	if is_possessed:
		if current_demon_type == DemonData.DemonType.OBSESSIVE:
			demon_type_obsessive.visible = true
			demon_type_obsessive._on_set_demon(current_demon)
			demon_type_obsessive._on_set_health(current_demon)
		
	
func is_holding_cross():
	return GameState.item_in_hand == item_cross
