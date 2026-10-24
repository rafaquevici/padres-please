extends AnimatableBody2D

@export var velocidade_max := 1000.0   

func _physics_process(delta: float) -> void:
	var alvo := get_global_mouse_position()
	global_position = global_position.move_toward(alvo, velocidade_max * delta)
