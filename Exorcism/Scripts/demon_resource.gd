class_name DemonData
extends Resource

enum DemonType {
	OBSSESIVE,
	POSSESIVE,
}

@export var demon_name: String 
@export var demon_catalog_icon: Texture2D
@export var demon_type: DemonType
@export var skill1: String
@export var skill2: String
@export var skill3: String
@export var health: int 
