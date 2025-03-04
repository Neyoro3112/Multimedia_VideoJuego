extends PlayerState
class_name PlayerJumping

@onready var timer = $JumpExtendDuration

func enter():
	player.velocity.y = -player.jump_speed
	timer.one_shot = true
	timer.wait_time = player.jump_time
	timer.start()

func update(_delta: float):
	player.animation_controller.update_animation(PlayerAnimations.Jump)
	pass
	

func physics_update(delta: float):
	update_physics(delta, player.speed)

	# Mientras el botón de salto esté presionado, permite extender el salto
	if Input.is_action_pressed("jump") and not timer.is_stopped():
		player.velocity.y = -player.jump_speed
	else:
		timer.stop()

	# Cuando el tiempo de salto se acaba, pasa a caída
	if player.velocity.y >= 0 or player.is_on_ceiling():
		transitioned.emit(self, FALLING)

func exit():
	timer.stop()
