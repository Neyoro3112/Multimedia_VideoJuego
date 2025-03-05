extends Node
class_name StateMachine

@export var initial_state: State

var states: Dictionary = {}
var current_state: State
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(new_state_name: String):
	#if state != current_state: 
		#print("Trying transition from ", state.name)
		#return
	
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state: return
	if current_state:
		current_state.exit()
		
	current_state = new_state
	current_state.enter()
