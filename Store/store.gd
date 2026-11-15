extends Control

@export var items: Array[ItemData] = []

@onready var store_slots = $GridContainer
@onready var money: Label = $Money
@onready var button: Button = $Button


func _ready():
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
	button.pressed.connect(open_exorcism)

func _on_slot_gui_input(event: InputEvent, slot: Slot):
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_RIGHT \
			and event.pressed:
		slot.buy_item()
		
func _update_money():
	money.text = str(GameState.current_money) + ",00✞"

func open_exorcism():
	get_tree().change_scene_to_file("res://Exorcism/Exorcism.tscn")
