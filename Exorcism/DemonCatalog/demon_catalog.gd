extends Control

# Recursos dos demônios
@export var ObsessiveDemon: DemonData
@onready var capa: TextureRect = $Capa

# Filhos da cena
@onready var page: Panel = $Page
@onready var UI_demon_name: Label = $Page/Name
@onready var UI_demon_texture: TextureRect = $Page/Texture
@onready var UI_demon_skills: Label = $Page/Description/Skills
@onready var close_button: Button = $Page/CloseButton

@onready var pass_left: Button = $Page/PassLeft
@onready var pass_right: Button = $Page/PassRight

@onready var skill_1: LineEdit = $Page/Description/skill1
@onready var skill_2: LineEdit = $Page/Description/Skill2
@onready var skill_3: LineEdit = $Page/Description/Skill3

var current_page: int = 0

@onready var page_array: Array[DemonData] = [ObsessiveDemon]

var page_data_skill1: Dictionary = {}
var page_data_skill2: Dictionary = {}
var page_data_skill3: Dictionary = {}

signal not_visible


func _ready():
	pass_left.pressed.connect(_on_pass_left_pressed)
	pass_right.pressed.connect(_on_pass_right_pressed)
	close_button.pressed.connect(_on_close_pressed)

	skill_1.text_changed.connect(_skill1_changed)
	skill_2.text_changed.connect(_skill2_changed)
	skill_3.text_changed.connect(_skill3_changed)

	capa.mouse_filter = Control.MOUSE_FILTER_STOP
	capa.gui_input.connect(_capa_gui_input)

	_change_page(0)


func _demon_index() -> int:
	return current_page - 1


func _skill1_changed(new_text: String):
	if current_page == 0:
		return
	page_data_skill1[_demon_index()] = new_text


func _skill2_changed(new_text: String):
	if current_page == 0:
		return
	page_data_skill2[_demon_index()] = new_text


func _skill3_changed(new_text: String):
	if current_page == 0:
		return
	page_data_skill3[_demon_index()] = new_text


func _change_page(number_page: int):
	# Total de páginas = capa + demônios
	var total_pages: int = page_array.size() + 1

	if number_page < 0 or number_page >= total_pages:
		return

	current_page = number_page

	# Capa
	if current_page == 0:
		page.hide()
		capa.show()
		return

	# Página de demônio
	capa.hide()
	page.show()

	var idx: int = _demon_index()
	var demon_data: DemonData = page_array[idx]

	UI_demon_name.text = demon_data.demon_name
	UI_demon_texture.texture = demon_data.demon_catalog_icon

	skill_1.text = page_data_skill1.get(idx, "")
	skill_2.text = page_data_skill2.get(idx, "")
	skill_3.text = page_data_skill3.get(idx, "")


func _on_pass_left_pressed():
	_change_page(current_page - 1)


func _on_pass_right_pressed():
	_change_page(current_page + 1)


func _on_close_pressed():
	self.visible = false
	not_visible.emit()


func _capa_gui_input(event: InputEvent):
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.pressed:
		_change_page(1)
