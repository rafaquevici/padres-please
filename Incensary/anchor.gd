extends AnimatableBody2D

@export var velocidade_max := 1000.0

@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	var alvo := get_global_mouse_position()
	var deslocamento := sprite.global_position - global_position
	var destino := alvo - deslocamento

	global_position = global_position.move_toward(
		destino,
		velocidade_max * delta
	)
