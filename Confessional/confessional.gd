
extends CanvasLayer

@export var database: NpcDatabase

var npc: NpcData
var typing_speed: float = 0.035
var typing: bool = false
var decision_locked: bool = false

var generator: NpcGenerator

var current_letter_sound: AudioStream

@onready var dialogue: Label = $Control/Dialogue
@onready var npc_name: Label = $Control/NpcName
@onready var timer_label: Label = $Control/TimerLabel
@onready var cross: AnimatedSprite2D = $Control/Cross
@onready var letter_sound_player: AudioStreamPlayer = $LetterSound
@onready var fade: ColorRect = $Fade

@onready var controlDialogue: int = 0

const FORGIVE_ATORMENTED_PERSON_1 = preload("uid://brfrok4hw4j3d")
const FORGIVE_DEMON_DIALOGUES_1 = preload("uid://dorycj301yjke")
const lettersounds = preload("uid://d2wedde0p5uyq")


func _ready() -> void:
	generator = NpcGenerator.new(database)

	GameState.day_ending.connect(_on_day_ending)
	GameState.day_started.connect(_on_day_started)

	generate_next_npc()




func _on_day_ending() -> void:

	get_tree().paused = true


	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(fade, "color:a", 1.0, 2.5)

	await tween.finished


	GameState.prepare_next_day()


	tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(fade, "color:a", 0.0, 2.5)

	await tween.finished


	get_tree().paused = false
	GameState.resume_day()

	
	type_text(npc.dialogue.dialogues[0])


func _on_day_started() -> void:
	generate_next_npc(false)



func choose_letter_sound() -> void:
	current_letter_sound = lettersounds.letter_sound_array.pick_random()




func _on_talk_more_pressed() -> void:
	if typing or decision_locked:
		return

	if controlDialogue < 2:
		controlDialogue += 1
		type_text(npc.dialogue.dialogues[controlDialogue])
	else:
		dialogue.text = "..."




func _on_forgive_pressed() -> void:
	if typing or decision_locked:
		return

	decision_locked = true

	var consequence: String

	if npc.possessed:
		consequence = FORGIVE_DEMON_DIALOGUES_1.dialogues.pick_random()
	else:
		consequence = FORGIVE_ATORMENTED_PERSON_1.dialogues.pick_random()

	await type_text(consequence)

	if npc.possessed:
		await get_tree().create_timer(10.0).timeout
	else:
		await get_tree().create_timer(5.0).timeout

	generate_next_npc()
	decision_locked = false



func _on_exorcism_pressed() -> void:
	if typing or decision_locked:
		return

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
			letter_sound_player.stream = current_letter_sound
			letter_sound_player.play()

		await get_tree().create_timer(typing_speed).timeout

	typing = false



func generate_next_npc(show_dialogue: bool = true) -> void:
	npc = generator.generate_npc()
	GameState.current_npc = npc

	choose_letter_sound()

	controlDialogue = 0
	npc_name.text = npc.name
	dialogue.text = ""

	cross_animation()

	if show_dialogue:
		type_text(npc.dialogue.dialogues[0])
