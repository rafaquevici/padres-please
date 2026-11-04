extends Node

var item_in_hand: Control = null
var current_npc: NpcData = null

func is_holding_cross() -> bool:
	return item_in_hand != null and item_in_hand.name == "ItemCross"

var current_day: int = 1
var faith: int = 100
var max_faith = 200
var days_total: int = 5
var day_duration: float = 300.0
var time_remaining: float = 300.0
var time_running: bool = false

func _process(delta: float) -> void:
	if not time_running:
		return
	time_remaining -= delta
	if time_remaining <= 0:
		time_remaining = 0
		time_running = false

func gain_faith(amount: int) -> void:
	faith += amount

func lose_faith(amount:int) -> void:
	faith -= amount
	faith = min(faith, max_faith)

func start_day() -> void:
	time_remaining = day_duration
	time_running = true

func _ready() -> void:
	start_day()
