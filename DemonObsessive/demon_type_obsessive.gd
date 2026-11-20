extends Control

@onready var demon_animation: AnimatedSprite2D = $Demon
@onready var dano: AudioStreamPlayer = $Dano

var health: int
var demon: DemonData
var is_alive: bool = true

signal died

func _ready():
	demon_animation.play()
	randomize()
	random_position()
	gui_input.connect(_on_demon_input)
	if !is_alive:
		died.emit()

func random_position():
	var screen_size = get_viewport_rect().size

	var limit_x = screen_size.x - size.x - 300
	var limit_y = screen_size.y - size.y - 200

	var x_random = randf_range(300, limit_x)
	var y_random = randf_range(0, limit_y)

	position = Vector2(x_random, y_random)

func _on_demon_input(event: InputEvent):
	if not is_alive:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if GameState.is_holding_cross():
			random_position()
			take_demage(10)
		if GameState.is_holding_pistol():
			take_demage(100000)
		if GameState.is_holding_stamp():
			take_demage(100000)

func _on_set_demon(specific_demon: DemonData):
	demon = specific_demon

func _on_set_health(demon: DemonData):
	health = demon.health
	
func take_demage(damage: int):
	health = max(health - damage, 0)
	dano.play()
	if health <= 0 and is_alive:
		is_alive = false
		died.emit()
		_on_dead()
	print(health)
	
func _on_dead():
	self.queue_free()

	
	
