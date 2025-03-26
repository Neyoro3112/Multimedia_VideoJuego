class_name AudioCullingSettings
extends Resource

@export_range(0, 10) var limit: int = 8
@export var audio_stream: AudioStream
@export_range(-60,20) var volume: float = 0
@export var bus: StringName
@export_range(0.,4.,.05) var pitch_scale: float = 1.

var current_instance_count: int : # Aun no se como llamarla pero es para manejar el famoso Culling, ayuda con esto tambien GPT
	set(value):
		current_instance_count = clampi(value,0, limit)
		
func max_reached() -> bool:
	return current_instance_count >= limit
	
func on_audio_finished() -> void:
	print("AudioFinished")
	current_instance_count -= 1
