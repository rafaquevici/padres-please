
extends Node

@onready var exorcism: Exorcism = $"../.."
@onready var cursor: TextureRect = $"../../UI/Cursor/Cursor"
@onready var item_cross: Button = $"../../UI/Moving_scenario/Fixed_items/ItemCross"
@onready var incensary: Button = $"../../UI/Moving_scenario/Fixed_items/Incensary"
@onready var smoke_container: CanvasLayer = $"../../UI/Smoke_Container"
@onready var consumables: Control = $"../../UI/Moving_scenario/Consumables"

@export var item_cross_texture: Texture2D
@export var incensary_texture: Texture2D
@export var closed_hand: Texture2D
@export var holding_cross_hand: Texture2D

var incensary_instance: Node2D
var smoke: GPUParticles2D

var incensary_scene = preload("res://Incensary/Incensary.tscn")


func _on_item_cross_pressed():
	if item_cross.icon != null and cursor.texture == closed_hand and GameState.item_in_hand == null:
		cursor.texture = holding_cross_hand
		item_cross.icon = null
		GameState.item_in_hand = item_cross

	elif GameState.item_in_hand == item_cross:
		item_cross.icon = item_cross_texture
		GameState.item_in_hand = null
		cursor.texture = closed_hand


func _on_item_incencary_pressed():
	if incensary_instance == null and cursor.texture == closed_hand and GameState.item_in_hand == null:
		incensary_instance = incensary_scene.instantiate()
		incensary_instance.position = exorcism.get_global_mouse_position()
		smoke_container.add_child(incensary_instance)

		GameState.item_in_hand = incensary
		incensary.icon = null
		cursor.texture = null

	elif GameState.item_in_hand == incensary:
		incensary.icon = incensary_texture
		GameState.item_in_hand = null

		smoke = get_incensary_child()
		smoke.reparent(smoke_container, true)
		smoke.emitting = false

		get_tree().create_timer(smoke.lifetime).timeout.connect(smoke.queue_free)

		incensary_instance.queue_free()
		incensary_instance = null

		cursor.texture = closed_hand


func get_incensary_child() -> GPUParticles2D:
	return incensary_instance.get_child(0) as GPUParticles2D


func is_holding_cross() -> bool:
	return GameState.item_in_hand == item_cross


func _on_consumable_pressed(button: Button) -> void:
	var item: ItemData = button.get_meta("item", null)

	if item == null:
		return

	if button.icon != null and cursor.texture == closed_hand and GameState.item_in_hand == null:
		cursor.texture = item.holding_texture
		button.icon = null
		GameState.item_in_hand = button

	elif GameState.item_in_hand == button:
		button.icon = item.texture
		GameState.item_in_hand = null
		cursor.texture = closed_hand
