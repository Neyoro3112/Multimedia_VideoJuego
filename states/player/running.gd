extends PlayerState
class_name PlayerRunning

func get_transition_checks():
	return { 
		PlayerStates.Movement.falling not player.is_on_floor(),
		PlayerStates.Movement.jumping player.controller.is_action_triggered(PlayerActions.jump),
		ATTACKING: player.controller.is_action_triggered(PlayerActions.attack),
		PlayerStates.Movement.rolling player.controller.is_action_triggered(PlayerActions.roll),
		IDLE: player.direction == 0,
		PlayerStates.Movement.walking not player.controller.is_action_held(PlayerActions.run)
	}
func enter():
	player.animation_controller.update_animation(PlayerAnimations.Run)
	
func physics_update(delta: float):
	update_physics(delta, player.run_speed)

	check_transitions()
