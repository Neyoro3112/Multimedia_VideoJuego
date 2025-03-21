extends EnemyState
@onready var spotting_timer: Timer = $SpottingTimer

func get_transition_checks():
	return {
		EnemyStates.Movement.Chasing: spotting_timer.is_stopped()
	}
	
func get_animation_checks():
	return {
		FlyEnemyAnimations.SpottedPlayer: true
	}

func enter():
	spotting_timer.start()
	update_animation()

	
func physics_update(_delta: float):
	check_transitions()
