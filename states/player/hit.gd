extends PlayerState
class_name PlayerHit

var knockback_handler: KnockbackHandler

func _ready():
	knockback_handler = KnockbackHandler.new(self)

func get_transition_checks():
	return {
		PlayerStates.Action.no_action: true
	}

func get_animation_checks():
	print("Comparing States: ", player.movement_fsm.current_state.name.to_lower(), " / ", PlayerStates.Movement.rolling)
	return {
		PlayerAnimations.CrouchHit: player.movement_fsm.is_current_state(PlayerStates.Movement.rolling),
		PlayerAnimations.Hit: true
	}

func enter():
	update_animation()
	player.direction = -knockback_handler.knockback_direction
	player.velocity.y = -abs(knockback_handler.velocity)
	knockback_handler.start_knockback()
	player.movement_fsm.paused = true

func physics_update(delta: float):
	knockback_handler.apply_knockback(delta, player)
	player.apply_gravity(delta)
	player.move_and_slide()
	if player.velocity.x == 0:
		check_transitions()
		
func exit():
	player.movement_fsm.paused = false




func _on_hurt_box_hit(_dmg: int, healthComponent: HealthComponent, hitbox: HitBox) -> void:
	if not healthComponent.is_alive: return
	knockback_handler.setup_knockback(hitbox, player.position)
	transitioned.emit(PlayerStates.Action.hit)
