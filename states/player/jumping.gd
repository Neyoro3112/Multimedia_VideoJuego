extends PlayerState
class_name PlayerJumping

@onready var timer = $JumpExtendDuration

func enter():
	player.velocity.y = -player.jump_speed
	timer.start()
	player.animation_controller.update_animation(PlayerAnimations.Jump)
	
func get_transition_checks():
	return {
		FALLING: player.velocity.y >= 0 or player.is_on_ceiling()
	}
func physics_update(delta: float):
	update_physics(delta, player.speed)

	# Mientras el botón de salto esté presionado, permite extender el salto
	var is_holding_jump = player.controller.is_action_held(PlayerActions.jump)
	if is_holding_jump and not timer.is_stopped():
		player.velocity.y = -player.jump_speed
	#elif not is_holding_jump:
		#player.velocity.y = 0	
	else:
		timer.stop()

	check_transitions()

func exit():
	timer.stop()
