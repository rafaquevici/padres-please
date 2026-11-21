extends Control
@onready var play_again: Button = $play_again


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	play_again.pressed.connect(restart)

func restart():
	GameState.restart_game()
