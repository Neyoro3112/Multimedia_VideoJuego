extends PlayerState
class_name PlayerHit

var knockback_handler: KnockbackHandler

func _ready():
	knockback_handler = KnockbackHandler.new(self)
	transition_checks = [
		should_transition_to_jump(false),
		should_transition_to_attack, 
		should_transition_to_fall, 
		should_transition_to_roll,
		should_transition_to_walk,
		should_transition_to_idle
	]

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
	apply_gravity(delta)
	player.move_and_slide()
	if player.velocity.x == 0:
		#player.direction = 0
		print("Trying transition: ", player.direction)
		check_transitions()
		
func exit():
	print("Ended hit")
