class_name PlayerAttacking
extends PlayerState


@onready var timer = $AttackDuration
@onready var cooldown_timer: Timer = $CooldownTimer

func get_transition_checks():
	return {
		PlayerStates.Action.no_action: true, 
	}

func can_enter():
	return cooldown_timer.is_stopped()

func enter():
	player.speed_multiplier = 0.5
	player.movement_fsm.set_blocked_states([PlayerStates.Movement.jumping, PlayerStates.Movement.rolling])
	player.animation_controller.randomize_animation(PlayerAnimations.Attack, 3)
	player.animation_controller.update_animation(PlayerAnimations.Attack, true)
	timer.start()
func physics_update(_delta: float):
	if timer.is_stopped():
		check_transitions()	

func exit():
	player.speed_multiplier = 1
	cooldown_timer.start()
	player.movement_fsm.clear_blocked_states()
