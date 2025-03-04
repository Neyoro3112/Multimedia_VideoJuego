extends PlayerState
class_name PlayerRunning

func enter():
	transition_checks = [
		should_transition_to_jump(),
		should_transition_to_attack,
		should_transition_to_fall, 
		should_transition_to_roll,
		should_transition_to_idle,
		should_transition_to_run,
		func(): return WALKING if Input.is_action_just_released(PlayerAnimations.Run) else ""
	]

func update(_delta: float):
	player.animation_controller.update_animation(PlayerAnimations.Run)
	check_transitions()
func physics_update(delta: float):
	update_physics(delta, player.run_speed)

	# Transiciones propias de Walking
	
