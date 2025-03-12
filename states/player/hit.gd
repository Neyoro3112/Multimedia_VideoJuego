extends PlayerState
class_name PlayerHit

var knockback_handler: KnockbackHandler

func _ready():
	knockback_handler = KnockbackHandler.new(self)

func get_transition_checks():
	return {
		FALLING: not player.is_on_floor(), 
		JUMPING: player.controller.is_action_triggered(PlayerActions.jump),
		ATTACKING: player.controller.is_action_triggered(PlayerActions.attack), 
		ROLLING: player.controller.is_action_triggered(PlayerActions.roll),
		IDLE: player.direction ==0,
		WALKING: true
	}

func _on_hurt_box_hit(dmg: int, hitbox: HitBox) -> void:
	if dmg == 0: return
	knockback_handler.setup_knockback(hitbox, player.position)
	transitioned.emit(HIT)

func enter():
	player.animation_controller.update_animation(PlayerAnimations.Hit)
	player.direction = -knockback_handler.knockback_direction
	player.velocity.y = -abs(knockback_handler.velocity)
	knockback_handler.start_knockback()

func physics_update(delta: float):
	knockback_handler.apply_knockback(delta, player)
	player.apply_gravity(delta)
	player.move_and_slide()
	if player.velocity.x == 0:
		check_transitions()
