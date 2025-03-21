extends PlayerState
class_name PlayerDeath

@export var knockback_movement_component: KnockbackMovement


func enter():
	player.movement_component = knockback_movement_component
	knockback_movement_component.init(player)
	player.animation_controller.update_animation(PlayerAnimations.Death)
	player.movement_fsm.paused = true

func physics_update(delta: float):
	player.update_physics(delta)
	player.move_and_slide()


func _on_hurt_box_hit(_dmg: int, healthComponent: HealthComponent, hitbox: HitBox) -> void:
	if healthComponent.is_alive: return
	knockback_movement_component.setup_knockback(hitbox, player)
	transitioned.emit(PlayerStates.Action.death)
