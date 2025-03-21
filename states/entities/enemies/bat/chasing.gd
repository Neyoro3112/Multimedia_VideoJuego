extends EnemyState

@onready var random_point_timer: Timer = $RandomPointTimer
@export var fly_movement: FlyMovementComponent

func get_transition_checks():
	return {
		EnemyStates.Movement.Attacking: enemy.controller.is_action_triggered(EnemyActions.attack)
	}

func get_animation_checks():
	return {
		FlyEnemyAnimations.Bite: true
	}

func enter():
	update_animation()
	enemy.movement_component = fly_movement
	fly_movement.target_point = enemy.controller.select_random_point()
	random_point_timer.start()
	
func physics_update(delta: float):
	if not enemy.target: return
	enemy.update_physics(delta)
	check_transitions()
	
func exit():
	random_point_timer.stop()

func _on_random_point_timer_timeout() -> void:
	fly_movement.target_point = enemy.controller.select_random_point()
