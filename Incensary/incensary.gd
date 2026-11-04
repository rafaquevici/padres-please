extends Node2D

@export var velocidade_max := 1000.0

@onready var marker_2d: Marker2D = $Object/incensary/Marker2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var sprite: Sprite2D = $Object/Anchor/Sprite2D
@onready var anchor: AnimatableBody2D = $Object/Anchor


func _process(delta: float) -> void:
	if gpu_particles_2d and marker_2d:
		gpu_particles_2d.global_position = marker_2d.global_position
