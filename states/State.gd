extends Node
class_name State

signal transitioned

var transition_checks: Array[Callable]



func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass


func check_transitions(transitionList: Array[Callable] = []):
	var checking_list = transitionList if transitionList else transition_checks
	
	for check in checking_list:
		var next_state = check.call()  # Llamar a la función de verificación
		if next_state:  # Si devuelve un estado válido
			transitioned.emit(next_state)
			return
