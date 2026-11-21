class_name DemonData
extends Resource

signal health_changed(new_health: int)

enum DemonType {
	OBSESSIVE,
	POSSESSIVE,
}

@export var demon_name: String 
@export var demon_catalog_icon: Texture2D
@export var demon_type: DemonType
@export var skill1: String
@export var skill2: String
@export var skill3: String
@export var health: int 

func take_damage(damage: int) -> void:
	health = max(health - damage, 0)
	health_changed.emit(health)
	
func kill() -> void:
	take_damage(health)
