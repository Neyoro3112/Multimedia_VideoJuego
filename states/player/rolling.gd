extends PlayerState
class_name PlayerRolling

@onready var timer = $RollDuration
var original_timescale: float

func enter():
	original_timescale = player.animation_controller.get_animation_timescale(PlayerAnimations.Roll)
	print("Timescale: ",original_timescale)
	transition_checks = [
		should_transition_to_jump(false),
		should_transition_to_walk,
		should_transition_to_idle
	]
	timer.one_shot = true
	timer.wait_time = player.roll_time
	timer.start()
	player.animation_controller.update_animation(PlayerAnimations.Roll)

func update(_delta: float):
	if timer.is_stopped() and not player.rollBlockinCeiling.is_colliding():
		check_transitions()
func physics_update(delta: float):
	update_physics(delta, 0, func():
		var roll_progress = timer.time_left / timer.wait_time
		player.animation_controller.change_animation_timescale(PlayerAnimations.Roll, lerp(original_timescale*0.3, original_timescale, roll_progress))
		player.velocity.x = (1 if player.facing_right else -1) * lerp(player.roll_speed * 0.08, player.roll_speed, roll_progress)
	)
	
	

func exit():
	player.animation_controller.change_animation_timescale(PlayerAnimations.Roll, original_timescale)
	player.roll_cooldown_timer.start()  # Iniciar cooldown al salir del estado
	
