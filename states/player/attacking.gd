extends PlayerState


@onready var timer = $AttackDuration
# Called when the node enters the scene tree for the first time.
func enter():
	transition_checks = [
		should_transition_to_jump(false), 
		should_transition_to_fall, 
		should_transition_to_roll,
		should_transition_to_idle,
		should_transition_to_walk
	]
	player.animation_controller.randomize_animation(PlayerAnimations.Attack, 3)
	timer.one_shot = true
	timer.start()

func update(_delta: float):
	player.animation_controller.update_animation(PlayerAnimations.Attack)
	
	


func physics_update(_delta: float):
	update_physics(_delta, player.attack_speed)
	if timer.is_stopped():
		check_transitions()	
