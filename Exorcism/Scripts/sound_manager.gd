extends Node
@onready var music: AudioStreamPlayer = $Music


func play_music(is_playing: bool):
	music.playing = is_playing
	
