extends CanvasLayer

@export var database: NpcDatabase

var npc: NpcData
var typing_speed: float = 0.035
var typing: bool = false
@onready var dialogue: Label = $Control/Dialogue
@onready var controlDialogue: int = 0 
@onready var npc_name: Label = $Control/NpcName
const FORGIVE_ATORMENTED_PERSON_1 = preload("uid://brfrok4hw4j3d")
const FORGIVE_DEMON_DIALOGUES_1 = preload("uid://dorycj301yjke")
@onready var timer_label: Label = $Control/TimerLabel
@onready var cross: AnimatedSprite2D = $Control/Cross
@onready var letter_sound: AudioStreamPlayer = $LetterSound


func _ready() -> void:
	var generator = NpcGenerator.new(database)
	npc = generator.generate_npc()
	GameState.current_npc = npc
	cross_animation()
	print(npc.name)
	print(npc.possessed)
	
	type_text(npc.dialogue.dialogues[0])
	npc_name.text = npc.name
	

func _on_talk_more_pressed() -> void:
	if typing:
		return
	if controlDialogue < 2:
		controlDialogue = controlDialogue + 1
		type_text(npc.dialogue.dialogues[controlDialogue])
	else:
		dialogue.text = "..."

func _on_forgive_pressed() -> void:
	if npc.possessed:
		type_text(FORGIVE_DEMON_DIALOGUES_1.dialogues.pick_random())
	else:
		type_text(FORGIVE_ATORMENTED_PERSON_1.dialogues.pick_random())

func _on_exorcism_pressed() -> void:
	get_tree().change_scene_to_file("res://Exorcism/Exorcism.tscn")


func update_timer_display() -> void:
	var seconds = int(ceil(GameState.time_remaining))
	@warning_ignore("integer_division")
	var minutes = seconds / 60
	var remaining_seconds = seconds % 60
	timer_label.text = "%02d:%02d" % [minutes, remaining_seconds]

func _process(_delta: float) -> void:
	update_timer_display()

func cross_animation() -> void:
	if npc.possessed:
		cross.play("Cursed")
	else:
		cross.play("default")

func type_text(text_to_type: String) -> void:
	typing = true
	dialogue.text = ""

	for i in range(text_to_type.length()):
		dialogue.text += text_to_type[i]

		if text_to_type[i] != " ":
			letter_sound.play()

		await get_tree().create_timer(typing_speed).timeout

	typing = false
