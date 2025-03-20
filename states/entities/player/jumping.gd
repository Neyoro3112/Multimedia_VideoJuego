extends PlayerState
class_name PlayerJumping

@onready var timer = $JumpExtendDuration
@export var ground_movement_component: GroundMovement


func enter():
	player.movement_component = ground_movement_component
	player.velocity.y = -player.jump_speed
	timer.start()
	player.animation_controller.update_animation(PlayerAnimations.Jump)
	
func get_transition_checks():
	return {
		PlayerStates.Movement.falling: player.velocity.y >= 0 or player.is_on_ceiling()
	}

	
func physics_update(delta: float):
	var is_holding_jump = player.controller.is_action_held(PlayerActions.jump)
	# Mientras el botón de salto esté presionado, permite extender el salto
	if is_holding_jump and not timer.is_stopped():
		player.velocity.y = -player.jump_speed
	else:
		timer.stop()
	player.update_physics(delta)

	check_transitions()

func exit():
	timer.stop()
