class_name PlayerAttacking
extends PlayerState


@onready var timer = $AttackDuration

func get_transition_checks():
	return {
		FALLING: not player.is_on_floor(), 
		JUMPING: player.controller.is_action_triggered(PlayerActions.jump), 
		ROLLING: player.controller.is_action_triggered(PlayerActions.roll),
		IDLE: player.direction == 0,
		WALKING: true
	}

func enter():
	
	player.animation_controller.randomize_animation(PlayerAnimations.Attack, 3)
	player.animation_controller.update_animation(PlayerAnimations.Attack)
	timer.start()
func physics_update(_delta: float):
	update_physics(_delta, player.attack_speed)
	if timer.is_stopped():
		check_transitions()	
