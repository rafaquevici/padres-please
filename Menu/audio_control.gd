extends HSlider

var bus_name: String = "Master"
var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	value = db_to_linear(volume_db)

func _on_value_changed(value: float) -> void:
	print("Alterando volume Master para: ", value)

	if value <= 0.001:
		AudioServer.set_bus_mute(bus_index, true) # Ativa o mudo do jogo todo
	else:
		AudioServer.set_bus_mute(bus_index, false)
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(value)) # Define os decibéis
