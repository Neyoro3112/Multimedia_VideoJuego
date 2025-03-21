extends PlayerState
class_name PlayerIdle

func get_transition_checks():
	return {
		PlayerStates.Movement.falling: not player.is_on_floor(),
		PlayerStates.Movement.jumping: player.controller.is_action_triggered(PlayerActions.jump),
		PlayerStates.Movement.rolling: player.controller.is_action_triggered(PlayerActions.roll),
		PlayerStates.Movement.walking: player.direction != 0
	}

func enter():
	pass

func get_animation_checks():
	return {
		PlayerAnimations.Idle: player.action_fsm.is_current_state("No_action")
	}

func update(_delta: float):
	update_animation()



func physics_update(_delta: float):
	#update_physics(_delta)
	check_transitions()
	
