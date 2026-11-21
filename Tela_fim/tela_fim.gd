extends Control
@onready var play_again: Button = $play_again
@onready var label: Label = $Label


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	play_again.pressed.connect(restart)
	change_ending()

func change_ending():
	if GameState.current_ending == GameState.endings.GOOD:
		label.text = "O BEM VENCEU"
	if GameState.current_ending == GameState.endings.EVIL:
		label.text = "O MAU VENCEU"
	if GameState.current_ending == GameState.endings.HUMAN:
		label.text = "VOCÊ É PIOR QUE O DEMÔNIO"

func restart():
	GameState.restart_game()
