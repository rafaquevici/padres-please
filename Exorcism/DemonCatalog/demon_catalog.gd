extends Node2D

# resources dos demonios
@export var ryuk: DemonData
@export var muzan: DemonData

# filhos cena
@onready var page: Panel = $Page
@onready var UI_demon_name: Label = $Page/Name
@onready var UI_demon_texture: TextureRect = $Page/Texture
@onready var UI_demon_skills: Label = $Page/Description/Skills
@onready var pass_left: Button = $Page/PassLeft
@onready var pass_right: Button = $Page/PassRight

# outras variaveis
var current_page: int

@onready var page_array = [ryuk, muzan]

func _ready() -> void:
	pass_left.pressed.connect(_on_pass_left_pressed)
	pass_right.pressed.connect(_on_pass_right_pressed)
	_change_page(0)

func _change_page(number_page: int):
	current_page = number_page
	var demon_name = page_array[number_page].demon_name
	var demon_texture = page_array[number_page].demon_catalog_icon
	var demon_skills = page_array[number_page].description
	
	UI_demon_name.text = demon_name
	UI_demon_texture.texture = demon_texture
	UI_demon_skills.text = demon_skills

func _on_pass_left_pressed() -> void:
	_change_page(current_page - 1)

func _on_pass_right_pressed() -> void:
	_change_page(current_page + 1)
