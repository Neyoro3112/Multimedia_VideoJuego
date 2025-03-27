extends Node

@export var audio_dict: Dictionary[AudioGlobals.TYPES, AudioCullingSettings] = {}

@onready var music_controller: MusicController = $MusicController

func play_global_audio(type: AudioGlobals.TYPES) -> void:
	if audio_dict.has(type):
		var audio_culling_settings: AudioCullingSettings = audio_dict[type]
		if audio_culling_settings.max_reached(): return
		audio_culling_settings.current_instance_count += 1
		var new_audio: AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(new_audio)
		new_audio.bus = audio_culling_settings.bus
		new_audio.stream = audio_culling_settings.audio_stream
		new_audio.volume_db = audio_culling_settings.volume
		new_audio.pitch_scale = audio_culling_settings.pitch_scale
		new_audio.finished.connect(audio_culling_settings.on_audio_finished)
		new_audio.finished.connect(new_audio.queue_free)
		new_audio.play()
	else:
		push_error("Audio Culling setting not found: ", type)
