extends Control

@onready var demon_texture: TextureRect = $Demon
var health: int
var demon: DemonData
var is_alive: bool

signal is_dead

func _ready():
	randomize()
	random_position()
	demon_texture.gui_input.connect(_on_demon_input)
	if !is_alive:
		is_dead.emit()

func random_position():
	var screen_size = get_viewport_rect().size
	
	var limit_x = screen_size.x - size.x
	var limit_y = screen_size.y - size.y
	
	var x_random = randf_range(0, limit_x)
	var y_random = randf_range(0, limit_y)
	
	demon_texture.global_position = Vector2(x_random, y_random)

func _on_demon_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		random_position()
		
func _on_set_health(demon: DemonData):
	health = demon.health
	
func _on_set_demon(specific_demon: DemonData):
	demon = specific_demon
	
func change_health(damage: int):
	if damage >= health:
		health = health - damage
	else: 
		is_alive = false
	
