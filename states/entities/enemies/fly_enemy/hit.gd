extends EnemyState

@export var knockback_movement: KnockbackMovement


func get_transition_checks():
	return {
		EnemyStates.Movement.Idle: !enemy.target,
		EnemyStates.Movement.Chasing: true,
	}
	
func get_animation_checks():
	return {
		FlyEnemyAnimations.Hit: true
	}

func enter():
	update_animation(true)
	enemy.movement_component = knockback_movement
	knockback_movement.init(enemy)
	#enemy.velocity = Vector2.ZERO

	
func physics_update(_delta: float):
	enemy.update_physics(_delta)
	if enemy.velocity.x == 0:
		check_transitions()


func _on_hurt_box_hit(_dmg: int, _healthComponent: HealthComponent, hitbox: HitBox) -> void:
	if not _healthComponent.is_alive: return
	knockback_movement.setup_knockback(hitbox, enemy)
	transitioned.emit(EnemyStates.Actions.Hit)
