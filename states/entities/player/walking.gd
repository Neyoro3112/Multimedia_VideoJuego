extends PlayerState
class_name PlayerWalking

@export var ground_movement_component: GroundMovement

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

func enter():
	player.movement_component = ground_movement_component

func update(_delta: float):
	update_animation()
	

func physics_update(delta: float):
	ground_movement_component.speed_multiplier = 0.5 if player.action_fsm.is_current_state(PlayerStates.Action.attacking) else 1.
	player.update_physics(delta)
	check_transitions()
	
