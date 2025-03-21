extends PlayerState
class_name PlayerRolling

@onready var timer = $RollDuration
@onready var roll_cooldown = $RollCooldownTimer
@export var rolling_movement: RollingMovement


var original_timescale: float

func _ready():
	original_timescale = player.animation_controller.get_animation_timescale(PlayerAnimations.Roll)

func get_transition_checks():
	return {
		PlayerStates.Movement.jumping: player.controller.is_action_triggered(PlayerActions.jump),
		PlayerStates.Movement.walking: player.direction != 0,
		PlayerStates.Movement.idle: true
	}
func can_enter():
	return roll_cooldown.is_stopped()
func enter():
	player.movement_component = rolling_movement
	player.action_fsm.set_blocked_states([PlayerStates.Action.attacking])
	timer.start()
	player.animation_controller.update_animation(PlayerAnimations.Roll)
func update(_delta: float):
	if timer.is_stopped():
		player.animation_controller.update_animation(PlayerAnimations.Crouch)
func physics_update(delta: float):
	rolling_movement.progress = timer.time_left / timer.wait_time
	player.animation_controller.change_animation_timescale(PlayerAnimations.Roll, lerp(original_timescale*0.4, original_timescale, rolling_movement.progress))
	player.update_physics(delta)	
	if timer.is_stopped() and not player.rollBlockinCeiling.is_colliding() and player.is_on_floor():
		check_transitions()
func exit():
	player.animation_controller.change_animation_timescale(PlayerAnimations.Roll, original_timescale)
	roll_cooldown.start()
	player.action_fsm.clear_blocked_states()
	
