extends EnemyState

@export var knockback_movement: KnockbackMovement
@onready var free_timer: Timer = $FreeTimer


func get_transition_checks():
	return {
		
	}
	
func get_animation_checks():
	return {
		FlyEnemyAnimations.Hit: not enemy.is_on_floor(),
		FlyEnemyAnimations.Death: true
	}

func enter():
	enemy.contact_hitbox.active = false
	enemy.movement_component = knockback_movement
	knockback_movement.init(enemy)

func update(_delta: float):
	update_animation()
	
func physics_update(_delta: float):
	enemy.update_physics(_delta)
	if enemy.is_on_floor() and free_timer.is_stopped():
		free_timer.start()
		
func exit():
	pass


func _on_hurt_box_hit(_dmg: int, healthComponent: HealthComponent, hitbox: HitBox) -> void:
	if healthComponent.is_alive: return
	knockback_movement.setup_knockback(hitbox, enemy)
	transitioned.emit(EnemyStates.Actions.Death)


func _on_free_timer_timeout() -> void:
	enemy.queue_free()
