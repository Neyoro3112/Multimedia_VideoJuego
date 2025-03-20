extends EnemyState

var has_hit: bool
@onready var cooldown_timer: Timer = $cooldownTimer
@onready var attacking_span: Timer = $AttackingSpan
@export var fly_movement: FlyMovementComponent

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
	enemy.movement_component = fly_movement
	
	
func physics_update(delta: float):
	if not enemy.target: return
	fly_movement.target_point = enemy.target.global_position
	enemy.update_physics(delta)
	check_transitions()
func exit():
	has_hit = false
	cooldown_timer.start()
	attacking_span.stop()


func _on_hit_box_has_hit() -> void:
	has_hit = true
