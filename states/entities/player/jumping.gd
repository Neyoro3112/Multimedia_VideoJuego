extends PlayerState
class_name PlayerJumping

@onready var timer = $JumpExtendDuration
@export var jumping_movement_component: JumpingMovement

func get_transition_checks():
	return {
		PlayerStates.Movement.falling: player.velocity.y >= 0 or player.is_on_ceiling()
	}
func enter():
	player.movement_component = jumping_movement_component
	jumping_movement_component.init(player)
	timer.start()

func get_animation_checks():
	return {
		PlayerAnimations.Jump: player.action_fsm.is_current_state("No_action")
	}
	
func update(_d: float):
	update_animation()


func physics_update(delta: float):
	# Mientras el botón de salto esté presionado, permite extender el salto
	jumping_movement_component.extend_jump = player.controller.is_action_held(PlayerActions.jump) and not timer.is_stopped()
	if not jumping_movement_component.extend_jump: timer.stop()
	player.update_physics(delta)
	check_transitions()

func exit():
	timer.stop()
