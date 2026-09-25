extends Control
# Filhos cena
@onready var catalog_button: Button = $CatalogButton
@onready var demon_catalog: Control = $DemonCatalog
@onready var cursor: TextureRect = $Cursor
@onready var item_cross: Button = $ItemContainer1/ItemCross


@export var possessive_demons: Array[DemonData]
@export var obsessive_demons: Array[DemonData]

enum DemonTypes {
	OBSESSIVE,
	POSSESSIVE,
}
var current_demon_type: DemonTypes
var current_demon: DemonData
var is_possessed: bool

func _ready():
	randomize()
	_check_possession()
	_randomize_demon()
	_start_demon()
	catalog_button.pressed.connect(_open_catalog)
	demon_catalog.not_visible.connect(_on_catalog_visibility_changed)
	item_cross.pressed.connect(_on_item_cross_pressed)

	
func _process(delta: float):
	var mouse_pos: Vector2 = get_global_mouse_position()
	var half_size: Vector2 = cursor.size / 2.0
	cursor.global_position = mouse_pos - half_size
	
func _on_item_cross_pressed():
	if item_cross.icon != null:
		cursor.texture = item_cross.icon
		item_cross.icon = null	
	else:
		item_cross.icon = cursor.texture
		cursor.texture = null
	
func _randomize_demon():
	if is_possessed:
		var roll: float = randf()
		if roll < 0.7:
			current_demon_type = DemonTypes.OBSESSIVE
		else:
			current_demon_type = DemonTypes.POSSESSIVE
		if current_demon_type == DemonTypes.OBSESSIVE:
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
	pass
