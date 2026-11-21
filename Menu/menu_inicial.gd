extends Control

@onready var botoes_principais: VBoxContainer = %BotoesPrincipais
@onready var opcoes: Panel = %Opcoes

func _ready() -> void:
	botoes_principais.visible = true
	opcoes.visible = false

func _on_InciarJogo_pressed() -> void:
	GameState.start_game()

func _on_Opcoes_pressed() -> void:
	botoes_principais.visible = false
	opcoes.visible = true

func _on_Saida_pressed() -> void:
	get_tree().quit()

func _on_voltar_pressed() -> void:
	_ready()
