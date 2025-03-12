extends PlayerState
class_name PlayerRolling

@onready var timer = $RollDuration
var original_timescale: float

func _ready():
	original_timescale = player.animation_controller.get_animation_timescale(PlayerAnimations.Roll)

func get_transition_checks():
	return {
		JUMPING: player.controller.is_action_triggered(PlayerActions.jump),
		WALKING: player.direction != 0,
		IDLE: true
	}

func enter():
	timer.start()
	player.animation_controller.update_animation(PlayerAnimations.Roll)

func physics_update(delta: float):
	update_physics(delta, 0, func():
		var roll_progress = timer.time_left / timer.wait_time
		player.animation_controller.change_animation_timescale(PlayerAnimations.Roll, lerp(original_timescale*0.4, original_timescale, roll_progress))
		player.velocity.x = (1 if player.facing_right else -1) * lerp(player.roll_speed * 0.08, player.roll_speed, roll_progress)
	)
	if timer.is_stopped() and not player.rollBlockinCeiling.is_colliding() and player.is_on_floor():
		check_transitions()
	
	

func exit():
	player.animation_controller.change_animation_timescale(PlayerAnimations.Roll, original_timescale)
	player.roll_cooldown_timer.start()  # Iniciar cooldown al salir del estado
	
