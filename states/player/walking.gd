extends PlayerState
class_name PlayerWalking

func get_transition_checks():
	return {
		FALLING: not player.is_on_floor(),
		JUMPING: player.controller.is_action_triggered(PlayerActions.jump),
		ATTACKING: player.controller.is_action_triggered(PlayerActions.attack), 
		ROLLING: player.controller.is_action_triggered(PlayerActions.roll),
		IDLE: player.direction == 0,
		RUNNING: player.controller.is_action_held(PlayerActions.run)
	}
	
func enter():
	player.animation_controller.update_animation(PlayerAnimations.Walk)

func update(_delta: float):
	check_transitions()

func physics_update(delta: float):
	update_physics(delta, player.speed)
