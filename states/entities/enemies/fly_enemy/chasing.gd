extends EnemyState

var moveTo: Vector2
var randomDistanceFromTarget: float
@onready var random_point_timer: Timer = $RandomPointTimer

func get_transition_checks():
	return {
		EnemyStates.Movement.Attacking: enemy.position.distance_to(enemy.target.global_position) > 150
	}

func get_animation_checks():
	return {
		FlyEnemyAnimations.Bite: true
	}
func select_random_point():
	moveTo = enemy.target.global_position + Vector2(randf_range(-40,40),randf_range(-150,-75))

func enter():
	update_animation()
	select_random_point()
	random_point_timer.start()
	
func physics_update(_delta: float):
	if not enemy.target: return
	
	var movement_direction: Vector2 = enemy.position.direction_to(moveTo)
	enemy.direction = clampi(round(movement_direction.x), -1, 1)
	
	enemy.velocity += movement_direction * enemy.chasing_acceleration * _delta
	enemy.velocity = enemy.velocity.limit_length(enemy.max_speed)

	enemy.move_and_slide()
	check_transitions()
func exit():
	random_point_timer.stop()

func _on_random_point_timer_timeout() -> void:
	select_random_point()
