class_name MusicController
extends Node

@onready var music_player: AudioStreamPlayer = $MusicPlayer

func _ready():
	assert(music_player!=null, "Music controller needs to have a AudioStreamPlayer2D for the music")

var current_song: String :
	set(value):
		music_player["parameters/switch_to_clip"] = value
	get():
		return music_player["parameters/switch_to_clip"]

func pause():
	music_player.stream_paused = true
	music_player.stop()
func resume():
	if current_song:
		music_player.play()

func set_track(song_name: String):
	current_song = song_name
