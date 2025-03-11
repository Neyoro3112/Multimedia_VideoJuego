extends PlayerState
class_name PlayerRunning

func _ready():
	transition_checks = [
		should_transition_to_jump(),
		should_transition_to_attack,
		should_transition_to_fall, 
		should_transition_to_roll,
		should_transition_to_idle,
		should_transition_to_run,
		func(): return WALKING if Input.is_action_just_released(PlayerAnimations.Run) else ""
	]
func enter():
	player.animation_controller.update_animation(PlayerAnimations.Run)
	
func physics_update(delta: float):
	update_physics(delta, player.run_speed)

	check_transitions()
