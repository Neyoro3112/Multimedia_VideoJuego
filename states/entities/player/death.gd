extends PlayerState
class_name PlayerDeath

var knockback_handler: KnockbackHandler



func _ready():
	knockback_handler = KnockbackHandler.new(self)

func enter():
	knockback_handler.start_knockback()
	player.direction = -knockback_handler.knockback_direction
	player.velocity.y = -abs(knockback_handler.velocity)
	player.animation_controller.update_animation(PlayerAnimations.Death)
	player.movement_fsm.paused = true

func physics_update(delta: float):
	knockback_handler.apply_knockback(delta, player)
	player.apply_gravity(delta)
	player.move_and_slide()


func _on_hurt_box_hit(_dmg: int, healthComponent: HealthComponent, hitbox: HitBox) -> void:
	if healthComponent.is_alive: return
	knockback_handler.setup_knockback(hitbox, player.position)
	transitioned.emit(PlayerStates.Action.death)
