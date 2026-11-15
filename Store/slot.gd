extends Panel
class_name Slot

@onready var store: Control = $"../.."

var ItemClass = preload("res://Item/Item.tscn")
var PopUpClass = preload("res://Popup/Popup.tscn")
var item_var: Item
var pop_up: PopUp


func _ready() -> void:
	mouse_entered.connect(_mouse_entered)
	mouse_exited.connect(_mouse_exited)


func setup(data: ItemData) -> void:
	item_var = ItemClass.instantiate()
	add_child(item_var)
	item_var.set_item(data)
	
func buy_item():
	var item_slot := get_item()

	if item_slot == null or item_slot.resource == null:
		return

	var data: ItemData = item_slot.resource

	if GameState.current_money < data.price:
		print("Dinheiro insuficiente")
		return

	GameState.current_money -= data.price

	GameState.items_buyied.append(data)

	store._update_money()

	item_slot.queue_free()
	_close_popup()


func get_item() -> Item:
	for child in get_children():
		if child is Item:
			return child
	return null


func atualizar_popup(item: Item) -> PopUp:
	_close_popup()

	if item == null or item.resource == null:
		return null

	pop_up = PopUpClass.instantiate()
	add_child(pop_up)
	pop_up.set_text(item.resource)
	pop_up.z_index = 1000
	pop_up.global_position = global_position + Vector2(size.x + 10, -pop_up.size.y * 0.5)
	return pop_up


func _close_popup():
	if pop_up:
		pop_up.queue_free()
		pop_up = null


func _mouse_entered():
	atualizar_popup(get_item())


func _mouse_exited():
	_close_popup()
