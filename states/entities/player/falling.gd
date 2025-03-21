extends PlayerState
class_name PlayerFalling

@export var ground_movement_component: GroundMovement

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
	player.movement_component = ground_movement_component
func update(_delta: float):
	update_animation()

func physics_update(delta: float):
	player.update_physics(delta)

	if player.is_on_floor():
		check_transitions()
