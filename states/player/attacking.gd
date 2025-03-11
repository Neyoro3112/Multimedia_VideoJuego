class_name PlayerAttacking
extends PlayerState


@onready var timer = $AttackDuration
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	transition_checks = [
		should_transition_to_jump(false), 
		should_transition_to_fall, 
		should_transition_to_roll,
		should_transition_to_idle,
		should_transition_to_walk
	]

func enter():
	
	player.animation_controller.randomize_animation(PlayerAnimations.Attack, 3)
	player.animation_controller.update_animation(PlayerAnimations.Attack)
	timer.start()
func physics_update(_delta: float):
	update_physics(_delta, player.attack_speed)
	if timer.is_stopped():
		check_transitions()	
