extends PlayerState
class_name PlayerWalking

func get_transition_checks():
	return {
		PlayerStates.Movement.falling: not player.is_on_floor(),
		PlayerStates.Movement.jumping: player.controller.is_action_triggered(PlayerActions.jump),
		PlayerStates.Movement.rolling: player.controller.is_action_triggered(PlayerActions.roll),
		PlayerStates.Movement.idle: player.direction == 0,
	}

func get_animation_checks():
	return {
		PlayerAnimations.Walk: player.action_fsm.is_current_state("No_action")
	}

func update(_delta: float):
	update_animation()
	

func physics_update(delta: float):
	update_physics(delta, player.speed)
	check_transitions()
