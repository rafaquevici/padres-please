class_name ItemData
extends Resource

@export var name: String 
@export var texture: Texture
@export var holding_texture: Texture
@export var price: int
@export var description: String
@export var type: Type

enum Type {
	STAMP,
	PISTOL
}
