extends PlayerState
class_name PlayerIdle

func get_transition_checks():
	return {
		FALLING: not player.is_on_floor(),
		JUMPING: player.controller.is_action_triggered(PlayerActions.jump),
		ATTACKING: player.controller.is_action_triggered(PlayerActions.attack), 
		ROLLING: player.controller.is_action_triggered(PlayerActions.roll),
		WALKING: player.direction != 0
	}

func enter():
	player.animation_controller.update_animation(PlayerAnimations.Idle)



func physics_update(_delta: float):
	update_physics(_delta)
	check_transitions()
	
