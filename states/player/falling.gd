extends PlayerState
class_name PlayerFalling

func update(_delta: float):
	player.animation_controller.update_animation(PlayerAnimations.Fall)

func physics_update(delta: float):
	update_physics(delta, player.speed)

	# Asegurar transición correcta al tocar el suelo
	if player.is_on_floor():
		transitioned.emit(self, WALKING if player.direction != 0 else IDLE)
