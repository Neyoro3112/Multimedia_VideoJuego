extends PlayerState
class_name PlayerIdle

func enter():
	transition_checks = [
		should_transition_to_jump(),
		should_transition_to_attack, 
		should_transition_to_fall, 
		should_transition_to_roll,
		should_transition_to_walk
	]

func update(_delta: float):
	player.animation_controller.update_animation(PlayerAnimations.Idle)



func physics_update(_delta: float):
	update_physics(_delta)
	check_transitions()
	
