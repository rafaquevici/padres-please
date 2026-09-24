extends Control

# Recursos dos demônios
@export var ryuk: DemonData
@export var muzan: DemonData

# Filhos da cena
@onready var page: Panel = $Page
@onready var UI_demon_name: Label = $Page/Name
@onready var UI_demon_texture: TextureRect = $Page/Texture
@onready var UI_demon_skills: Label = $Page/Description/Skills

@onready var pass_left: Button = $Page/PassLeft
@onready var pass_right: Button = $Page/PassRight

@onready var skill_1: LineEdit = $Page/Description/skill1
@onready var skill_2: LineEdit = $Page/Description/Skill2
@onready var skill_3: LineEdit = $Page/Description/Skill3


# Página atual
var current_page: int = 0

# Array com os dados dos demônios
@onready var page_array: Array[DemonData] = [ryuk, muzan]

# Dados das skills de cada página
var page_data_skill1: Dictionary = {}
var page_data_skill2: Dictionary = {}
var page_data_skill3: Dictionary = {}


func _ready() -> void:
	pass_left.pressed.connect(_on_pass_left_pressed)
	pass_right.pressed.connect(_on_pass_right_pressed)

	skill_1.text_changed.connect(_skill1_changed)
	skill_2.text_changed.connect(_skill2_changed)
	skill_3.text_changed.connect(_skill3_changed)

	_change_page(0)


func _skill1_changed(new_text: String) -> void:
	page_data_skill1[current_page] = new_text


func _skill2_changed(new_text: String) -> void:
	page_data_skill2[current_page] = new_text


func _skill3_changed(new_text: String) -> void:
	page_data_skill3[current_page] = new_text


func _change_page(number_page: int) -> void:
	if number_page < 0 or number_page >= page_array.size():
		return

	current_page = number_page

	var demon_data: DemonData = page_array[current_page]

	# Dados do demônio
	UI_demon_name.text = demon_data.demon_name
	UI_demon_texture.texture = demon_data.demon_catalog_icon

	skill_1.text = page_data_skill1.get(current_page, "")
	skill_2.text = page_data_skill2.get(current_page, "")
	skill_3.text = page_data_skill3.get(current_page, "")


func _on_pass_left_pressed() -> void:
	_change_page(current_page - 1)


func _on_pass_right_pressed() -> void:
	_change_page(current_page + 1)
