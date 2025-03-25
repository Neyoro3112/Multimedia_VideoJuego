extends EnemyState


func get_transition_checks():
	return {
		EnemyStates.Actions.Spot: enemy.controller.is_action_triggered(EnemyActions.spotted)
	}
	
func get_animation_checks():
	return {
		
	}

func enter():
	enemy.detection_area.monitoring = true
	enemy.animation_controller.update_animation("idle")

func update(_delta: float):
	pass
	
func physics_update(_delta: float):
	check_transitions()

func exit():
	enemy.detection_area.monitoring = false
