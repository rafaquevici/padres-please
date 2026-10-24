extends Label


func _ready() -> void:
	text = str(GameState.current_money)+",00"+"✞"
