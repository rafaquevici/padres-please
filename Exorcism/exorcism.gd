class_name Exorcism
extends Control

# Filhos cena
@onready var catalog_button: Button = $Scenario/CatalogButton
@onready var demon_catalog: Control = $DemonCatalog
var incensary_instance: Node2D
@onready var cursor: TextureRect = $Cursor
@onready var item_cross: Button = $Scenario/ItemCross
@onready var incensary: Button = $Scenario/Incensary
@onready var demon_type_obsessive: Control = $DemonTypeObsessive
@onready var scenario: Control = $Scenario
@onready var cronometro: Node = $Cronometro
@onready var ir_loja: Button = $ir_loja



@export var possessive_demons: Array[DemonData]
@export var obsessive_demons: Array[DemonData]
@export var open_hand: Texture2D
@export var closed_hand: Texture2D
@export var holding_cross_hand: Texture2D
@export var item_cross_texture: Texture2D
@export var incensary_texture: Texture2D

var money_acquired: float

var current_demon_type: DemonData.DemonType 
var current_demon: DemonData
var is_possessed: bool = true

var animation_scene = preload("res://Animations/Characters.tscn")
var incensary_scene = preload("res://Incensary/Incensary.tscn")

func _ready():
	_get_character("genova", true)
	#_get_character(GameState.current_npc.animation, true) quando tiver 
	#is_possessed = GameState.current_npc.possessed
	GameState.exorcism_time = 0.0
	cronometro.counting = true
	randomize()
	_randomize_demon()
	_start_demon()
	_define_cursor()
	demon_type_obsessive.died.connect(end_exorcism)
	catalog_button.pressed.connect(_open_catalog)
	demon_catalog.not_visible.connect(_on_catalog_visibility_changed)
	item_cross.pressed.connect(_on_item_cross_pressed)
	incensary.pressed.connect(_on_item_incencary_pressed)
	ir_loja.pressed.connect(open_store)

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
		if 	demon_type_obsessive:
			demon_type_obsessive.position.y -= velocidade * delta
	elif mouse_pos.y < 10 and scenario.position.y < 250:
		scenario.position.y += velocidade * delta
		if 	demon_type_obsessive:
			demon_type_obsessive.position.y += velocidade * delta
		
	
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
		
func _on_item_incencary_pressed():
	if incensary_instance == null:
		incensary_instance = incensary_scene.instantiate()
		incensary_instance.position = get_global_mouse_position()
		add_child(incensary_instance)
		GameState.item_in_hand = incensary
		incensary.icon = null
		cursor.texture = null
	else:
		incensary.icon = incensary_texture
		GameState.item_in_hand = null
		incensary_instance.queue_free()
		incensary_instance = null
		cursor.texture = closed_hand
	
func _randomize_demon():
	if is_possessed:
		var roll: float = randf()
		current_demon_type = DemonData.DemonType.OBSESSIVE if roll < 1 else DemonData.DemonType.POSSESSIVE
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
	
func end_exorcism():
	cronometro.counting = false
	money_acquired = 10 - (GameState.exorcism_time * 0.001)
	GameState.current_money += money_acquired

func open_store():
	get_tree().change_scene_to_file("res://Store/Store.tscn")
