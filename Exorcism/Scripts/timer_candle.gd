extends TextureProgressBar

@export var total_duration: float = 50.0

func _process(_delta: float) -> void:
	if GameState.current_npc.possessed:
		var progress: float = clampf(GameState.exorcism_time / total_duration, 0.0, 1.0)

		value = 50.0 * (1.0 - progress)
		var cut_percent: float = 50.0 - value
		texture_progress_offset.y = texture_progress.get_height() * cut_percent / max_value
		if value == 0:
			GameState.finish_game(GameState.endings.EVIL)
