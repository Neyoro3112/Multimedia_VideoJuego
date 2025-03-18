extends EnemyState

var knockback_handler: KnockbackHandler

func _ready():
	knockback_handler = KnockbackHandler.new(self, 0.4)

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
	enemy.velocity = Vector2.ZERO
	enemy.direction = -knockback_handler.knockback_direction
	knockback_handler.start_knockback()

	
func physics_update(_delta: float):
	knockback_handler.apply_knockback(_delta, enemy)
	enemy.move_and_slide()
	if enemy.velocity.x == 0:
		check_transitions()
		


func _on_hurt_box_hit(_dmg: int, _healthComponent: HealthComponent, hitbox: HitBox) -> void:
	if not _healthComponent.is_alive: return
	knockback_handler.setup_knockback(hitbox, enemy.global_position)
	transitioned.emit(EnemyStates.Actions.Hit)
