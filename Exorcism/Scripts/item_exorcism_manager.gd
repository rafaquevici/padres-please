extends Node
@onready var exorcism: Exorcism = $".."

@onready var cursor: TextureRect = $"../UI/Cursor/Cursor"
@onready var incensary: Button = $"../UI/Moving_scenario/Z2/Fixed_items/Incensary"
@onready var item_cross: Button = $"../UI/Moving_scenario/Z2/Fixed_items/ItemCross"

@export var item_cross_texture: Texture2D
@export var incensary_texture: Texture2D
@export var open_hand: Texture2D
@export var closed_hand: Texture2D
@export var holding_cross_hand: Texture2D

var incensary_instance: Node2D
var smoke: GPUParticles2D
var incensary_scene = preload("res://Incensary/Incensary.tscn")

func _on_item_cross_pressed():
	if item_cross.icon != null:
		cursor.texture = holding_cross_hand
		item_cross.icon = null
		GameState.item_in_hand = item_cross
	else:
		item_cross.icon = item_cross_texture
		GameState.item_in_hand = null
		cursor.texture = closed_hand
		
func _on_item_incencary_pressed():
	if incensary_instance == null:
		incensary_instance = incensary_scene.instantiate()
		incensary_instance.position = exorcism.get_global_mouse_position()
		add_child(incensary_instance)
		GameState.item_in_hand = incensary
		incensary.icon = null
		cursor.texture = null
	else:
		incensary.icon = incensary_texture
		GameState.item_in_hand = null
		smoke = get_incensary_child()
		smoke.reparent(get_tree().current_scene, true)
		smoke.emitting = false
		get_tree().create_timer(smoke.lifetime).timeout.connect(smoke.queue_free)
		incensary_instance.queue_free()
		incensary_instance = null
		cursor.texture = closed_hand
		
func get_incensary_child() -> GPUParticles2D:
	smoke = incensary_instance.get_child(0)
	return smoke
		
func is_holding_cross():
	return GameState.item_in_hand == item_cross
		
	
