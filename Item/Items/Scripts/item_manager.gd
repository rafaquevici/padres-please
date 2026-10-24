extends Control
class_name Item

@export var resource: ItemData

@onready var texture_rect: TextureRect = $TextureRect


func _ready() -> void:
	_update_icon()


func set_item(new_res: ItemData) -> void:
	resource = new_res
	_update_icon()


func get_icon() -> Texture2D:
	return resource.texture if resource else null


func _update_icon() -> void:
	if not is_node_ready():
		return
	texture_rect.texture = get_icon()
