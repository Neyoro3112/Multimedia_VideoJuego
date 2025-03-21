extends Node
class_name State

signal transitioned

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
	
func can_enter() -> bool:
	return true

func get_transition_checks() -> Dictionary[String, bool]:
	return {}

func check_transitions():
	var transition_checks = get_transition_checks()
	for state_name in transition_checks:
		  # Llamar a la función de verificación
		
		if transition_checks[state_name]:  # Si devuelve un estado válido
			
			transitioned.emit(state_name)
			return
			
func get_animation_checks() -> Dictionary[String, bool]:
	return {}

func update_animation(start: bool = false):
	var animation_checks = get_animation_checks()
	for animation in animation_checks:
		if animation_checks[animation]:
			owner.animation_controller.update_animation(animation, start)
			return
