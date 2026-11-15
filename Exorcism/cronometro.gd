extends Node

var time: float = 0.0
var counting: bool = false

func _process(delta: float) -> void:
	if counting:
		time += delta
		GameState.exorcism_time += delta
		
