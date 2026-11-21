extends Control

@onready var demon_animation: AnimatedSprite2D = $Demon
@onready var dano: AudioStreamPlayer = $Dano
@onready var exorcism: Exorcism = $"../../../.."


var health: int
var demon: DemonData
var is_alive: bool = true

signal died


func _ready() -> void:
	demon_animation.play()
	randomize()
	random_position()
	gui_input.connect(_on_demon_input)


func setup_demon(specific_demon: DemonData) -> void:
	demon = specific_demon
	health = demon.health

	demon.health_changed.connect(_on_health_changed)


func _on_health_changed(new_health: int) -> void:
	health = new_health
	dano.play()

	print(demon.demon_name, " | Vida: ", health)

	if health <= 0 and is_alive:
		is_alive = false
		died.emit()
		_on_dead()


func random_position() -> void:
	var screen_size = get_viewport_rect().size

	var limit_x = screen_size.x - size.x - 300
	var limit_y = screen_size.y - size.y - 200

	var x_random = randf_range(300, limit_x)
	var y_random = randf_range(0, limit_y)

	position = Vector2(x_random, y_random)


func _on_demon_input(event: InputEvent) -> void:
	if not is_alive:
		return

	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:

		if GameState.is_holding_cross():
			random_position()
			take_damage(10)

		elif GameState.is_holding_pistol():
			print("detectou")
			exorcism.used_pistol()
			demon.kill()
			

func take_damage(damage: int) -> void:
	if not is_alive:
		return

	demon.take_damage(damage)


func _on_dead() -> void:
	queue_free()
