
extends Node

signal day_ending
signal day_started

var item_in_hand: Control = null
var current_npc: NpcData = null


func is_holding_cross() -> bool:
	return item_in_hand != null and item_in_hand.name == "ItemCross"



var current_day: int = 1
var days_total: int = 5

var day_duration: float = 10.0
var time_remaining: float = 10.0
var time_running: bool = false



var faith: int = 100
var max_faith: int = 200


func _ready() -> void:
	start_day()


func _process(delta: float) -> void:
	if not time_running:
		return

	time_remaining -= delta

	if time_remaining <= 0:
		time_remaining = 0
		end_day()


func start_day() -> void:
	time_remaining = day_duration
	time_running = true
	print("Começou o dia ", current_day)


func end_day() -> void:
	time_running = false

	if current_day < days_total:
		day_ending.emit()
	else:
		finish_game()


func prepare_next_day() -> void:
	current_day += 1
	time_remaining = day_duration
	day_started.emit()
	print("Preparando dia ", current_day)


func resume_day() -> void:
	time_running = true


func finish_game() -> void:
	time_running = false
	get_tree().paused = true

	print("FIM DE JOGO")



func gain_faith(amount: int) -> void:
	faith += amount
	faith = min(faith, max_faith)


func lose_faith(amount: int) -> void:
	faith -= amount
	faith = max(faith, 0)
