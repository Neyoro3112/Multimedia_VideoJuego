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

func physics_update(delta: float):
	knockback_handler.apply_knockback(delta, player)
	apply_gravity(delta)
	player.move_and_slide()


func _on_hurt_box_death(dmg: int, hitbox: HitBox) -> void:
	if dmg == 0: return
	knockback_handler.setup_knockback(hitbox, player.position)
	transitioned.emit(DEATH)
