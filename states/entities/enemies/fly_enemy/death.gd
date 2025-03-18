extends EnemyState

var knockback_handler: KnockbackHandler
@onready var free_timer: Timer = $FreeTimer

func _ready():
	knockback_handler = KnockbackHandler.new(self, 0.4)

func get_transition_checks():
	return {
		
	}
	
func get_animation_checks():
	return {
		FlyEnemyAnimations.Hit: not enemy.is_on_floor(),
		FlyEnemyAnimations.Death: true
	}

func enter():
	enemy.direction = -knockback_handler.knockback_direction
	enemy.velocity.y = -abs(knockback_handler.velocity)
	knockback_handler.start_knockback()

func update(_delta: float):
	update_animation()
	
func physics_update(_delta: float):
	knockback_handler.apply_knockback(_delta, enemy)
	enemy.apply_gravity(_delta)
	enemy.move_and_slide()
	if enemy.is_on_floor() and free_timer.is_stopped():
		free_timer.start()
		
func exit():
	pass


func _on_hurt_box_hit(_dmg: int, healthComponent: HealthComponent, hitbox: HitBox) -> void:
	if healthComponent.is_alive: return
	knockback_handler.setup_knockback(hitbox, enemy.global_position)
	transitioned.emit(EnemyStates.Actions.Death)


func _on_free_timer_timeout() -> void:
	enemy.queue_free()
