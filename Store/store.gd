extends Control

@export var items: Array[ItemData] = []
@onready var fade: ColorRect = $Fade
@onready var store_slots = $GridContainer
@onready var money: Label = $Money
@onready var init_day_button: Button = $Init_day

signal day_ending

func _ready():
	items = GameState.items
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	_update_money()

	var slots := store_slots.get_children()
	for i in slots.size():
		var slot := slots[i] as Slot
		if slot == null:
			continue
		slot.gui_input.connect(_on_slot_gui_input.bind(slot))
		if i < items.size():
			slot.setup(items[i])
	init_day_button.pressed.connect(init_day)

func _on_slot_gui_input(event: InputEvent, slot: Slot):
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_RIGHT \
			and event.pressed:
		slot.buy_item()
		
func _update_money():
	money.text = str(GameState.current_money) + ",00✞"

func init_day():
	get_tree().paused = true


	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(fade, "color:a", 1.0, 2.5)

	await tween.finished
	
	get_tree().change_scene_to_file("res://Confessional/confessional.tscn")
