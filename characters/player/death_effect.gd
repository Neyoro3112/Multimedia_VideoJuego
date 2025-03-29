extends Node2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready():
	gpu_particles_2d.emitting = true
	gpu_particles_2d.one_shot = true

func _on_gpu_particles_2d_finished() -> void:
	print("Particles out")
	queue_free()
