class_name Exorcism
extends Control

# Filhos cena
@onready var catalog_button: Button = $Scenario/CatalogButton
@onready var demon_catalog: Control = $DemonCatalog
@onready var cursor: TextureRect = $Cursor
@onready var item_cross: Button = $Scenario/ItemContainer1/ItemCross
@onready var demon_type_obsessive: Control = $Demons/DemonTypeObsessive
@onready var scenario: Control = $Scenario



@export var possessive_demons: Array[DemonData]
@export var obsessive_demons: Array[DemonData]
@export var open_hand: Texture2D
@export var closed_hand: Texture2D
@export var holding_cross_hand: Texture2D
@export var item_cross_texture: Texture2D

var current_demon_type: DemonData.DemonType 
var current_demon: DemonData
var is_possessed: bool = false

var animation_scene = preload("res://Animations/Characters.tscn")

func _ready():
	_get_character(GameState.current_npc.name, true)
	is_possessed = GameState.current_npc.possessed
	randomize()
	_randomize_demon()
	_start_demon()
	_define_cursor()
	catalog_button.pressed.connect(_open_catalog)
	demon_catalog.not_visible.connect(_on_catalog_visibility_changed)
	item_cross.pressed.connect(_on_item_cross_pressed)


	
func _define_cursor():
	if cursor.texture == closed_hand:
		cursor.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	else:
		cursor.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
func _process(delta: float):
	var velocidade: float = 100.0
	var mouse_pos: Vector2 = get_global_mouse_position()
	var window_size = DisplayServer.window_get_size()
	var half_size: Vector2 = cursor.size / 2.0
	cursor.global_position = mouse_pos - half_size
	if mouse_pos.y > (window_size.y - 10) and scenario.position.y > -250:
		scenario.position.y -= velocidade * delta	
	elif mouse_pos.y < 10 and scenario.position.y < 250:
		scenario.position.y += velocidade * delta
	
func _get_character(name: String, is_animated_p: bool):
	var new_character = animation_scene.instantiate()
	new_character.name_animation = name
	new_character.is_animated = is_animated_p
	new_character.z_index = -1
	scenario.add_child(new_character)
	
func _on_item_cross_pressed():
	if item_cross.icon != null:
		cursor.texture = holding_cross_hand
		item_cross.icon = null
		GameState.item_in_hand = item_cross
	else:
		item_cross.icon = item_cross_texture
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
	if GameState.item_in_hand == item_cross:
		pass
	else:
		demon_catalog.visible = true
		catalog_button.visible = false
	
func _on_catalog_visibility_changed():
	catalog_button.visible = true

func _start_demon():
	if is_possessed:
		if current_demon_type == DemonData.DemonType.OBSESSIVE:
			demon_type_obsessive.visible = true
			demon_type_obsessive._on_set_demon(current_demon)
			demon_type_obsessive._on_set_health(current_demon)
		
	
func is_holding_cross():
	return GameState.item_in_hand == item_cross
