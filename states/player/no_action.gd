class_name PlayerNoAction
extends PlayerState

func get_transition_checks():
	return {
		PlayerStates.Action.attacking: player.controller.is_action_triggered(PlayerActions.attack)
	}

func update(_delta: float):
	pass
	
func physics_update(_delta: float):
	check_transitions()
