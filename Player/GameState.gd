extends Node

signal day_ending
signal day_started

var item_in_hand: Control = null
var current_npc: NpcData = null
var current_money = 30
var exorcism_time: float = 0.0
var items_buyied: Array[ItemData] = []
var pistola = preload("uid://bphvj08yfxe8s")
var selo = preload("uid://d4e5dsh3gijxu")
var items: Array[ItemData] = [pistola, selo]


func is_holding_cross() -> bool:
	return item_in_hand != null and item_in_hand.name == "ItemCross"
	
func is_holding_pistol() -> bool:
	return item_in_hand != null and item_in_hand.name == "Pistol"
	
func is_holding_stamp() -> bool:
	return item_in_hand != null and item_in_hand.name == "Demon_Obssessive_Stamp"



var current_day: int = 5
var days_total: int = 5

var day_duration: float = 300.0
var time_remaining: float = 300.0
var time_running: bool = false


var faith: int = 100
var max_faith: int = 200


func _process(delta: float) -> void:
	if not time_running:
		return

	time_remaining -= delta

	if time_remaining <= 0:
		time_remaining = 0
		end_day()


func start_game() -> void:
	get_tree().paused = false
	time_remaining = day_duration
	time_running = true
	get_tree().change_scene_to_file("res://Confessional/confessional.tscn")
	print("Começou o dia ", current_day)


func end_day() -> void:
	time_running = false

	if current_day < days_total:
		get_tree().change_scene_to_file("res://Store/Store.tscn")
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
	get_tree().change_scene_to_file("res://Tela_fim/tela_fim.tscn")


func gain_faith(amount: int) -> void:
	faith += amount
	faith = min(faith, max_faith)

func lose_faith(amount: int) -> void:
	faith -= amount
	faith = max(faith, 0)
	
func restart_game() -> void:
	get_tree().paused = false
	current_money = 30
	items_buyied.clear()
	items = [pistola, selo]
	item_in_hand = null
	current_npc = null
	current_day = 1
	time_remaining = day_duration
	time_running = false
	faith = 100
	exorcism_time = 0.0
	start_game()
