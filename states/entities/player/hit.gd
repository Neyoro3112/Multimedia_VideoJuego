extends PlayerState
class_name PlayerHit

@export var knockback_movement_component: KnockbackMovement


func get_transition_checks():
	return {
		PlayerStates.Action.no_action: true
	}

func get_animation_checks():
	return {
		PlayerAnimations.CrouchHit: player.movement_fsm.is_current_state(PlayerStates.Movement.rolling),
		PlayerAnimations.Hit: true
	}

func enter():
	AudioGlobals.set_main_buses_effect_send(AudioBuses.Effects.HitEffect)
	player.movement_fsm.paused = true
	update_animation()
	knockback_movement_component.init(entity)
	player.movement_component = knockback_movement_component

func physics_update(delta: float):
	player.update_physics(delta)
	if player.velocity.x == 0:
		check_transitions()
		
func exit():
	AudioGlobals.reset_main_buses_send()
	player.revert_movement_component()
	player.movement_fsm.paused = false

func _on_hurt_box_hit(_dmg: int, healthComponent: HealthComponent, hitbox: HitBox) -> void:
	if not healthComponent.is_alive: return
	knockback_movement_component.setup_knockback(hitbox, player)
	transitioned.emit(PlayerStates.Action.hit)
	
