extends EnemyState

var has_hit: bool
@onready var cooldown_timer: Timer = $cooldownTimer
@onready var attacking_span: Timer = $AttackingSpan

func get_transition_checks():
	return {
		EnemyStates.Movement.Chasing: has_hit or attacking_span.is_stopped()
	}
	
func get_animation_checks():
	return {
		FlyEnemyAnimations.AggressiveBite: true
	}

func can_enter():
	return cooldown_timer.is_stopped()

func enter():
	update_animation()
	attacking_span.start()
	
func physics_update(_delta: float):
	if not enemy.target: return
	
	var movement_direction: Vector2 = enemy.position.direction_to(enemy.target.position)
	enemy.direction = clampi(round(movement_direction.x), -1, 1)
	
	enemy.velocity += movement_direction * enemy.attacking_acceleration * _delta
	enemy.velocity = enemy.velocity.limit_length(enemy.max_att_speed)
	enemy.move_and_slide()
	check_transitions()
func exit():
	has_hit = false
	cooldown_timer.start()
	attacking_span.stop()


func _on_hit_box_has_hit() -> void:
	has_hit = true
