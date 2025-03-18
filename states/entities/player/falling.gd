extends PlayerState
class_name PlayerFalling

func get_transition_checks():
	return {
		PlayerStates.Movement.walking: player.direction != 0,
		PlayerStates.Movement.idle: true
	}

func get_animation_checks():
	return {
		PlayerAnimations.Fall: player.action_fsm.is_current_state("No_action")
	}


func enter():
	update_animation()

func physics_update(delta: float):
	update_physics(delta, player.speed)

	if player.is_on_floor():
		check_transitions()
