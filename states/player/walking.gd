extends PlayerState
class_name PlayerWalking

func _ready():
	transition_checks = [
		should_transition_to_jump(),
		should_transition_to_attack,
		should_transition_to_fall, 
		should_transition_to_roll,
		should_transition_to_idle,
		should_transition_to_run
	]
	
func enter():
	player.animation_controller.update_animation(PlayerAnimations.Walk)

func update(_delta: float):
	check_transitions()

func physics_update(delta: float):
	update_physics(delta, player.speed)
