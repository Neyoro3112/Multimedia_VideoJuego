class_name AudioController
extends Node2D

@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	assert(audio_stream_player!=null, "Audio controller needs to have a AudioStreamPlayer2D")

var current_sfx: String :
	set(value):
		audio_stream_player["parameters/switch_to_clip"] = value
	get():
		return audio_stream_player["parameters/switch_to_clip"]


func update_sfx(audio_name: String):
	current_sfx = audio_name
	audio_stream_player.play()
