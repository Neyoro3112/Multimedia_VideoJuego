extends Node
class_name StateMachine

@export var initial_state: State
@export var paused: bool : set = set_paused
@export var blocked_states: Array[String] = []

signal transitioned(from: State, to: State)


var states: Dictionary[String, State] = {}
var current_state: State

func set_blocked_states(states_to_block: Array[String]):
	blocked_states = states_to_block
func clear_blocked_states():
	blocked_states = []

func is_current_state(stateName: String):
	
	return current_state and current_state.name.to_lower() == stateName.to_lower()


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

func set_paused(value: bool):
	paused = value
	set_process(not paused)
	set_physics_process(not paused)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(new_state_name: String):
	if new_state_name in blocked_states: return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state or !new_state.can_enter(): return
	if current_state:
		current_state.exit()
		
	transitioned.emit(current_state, new_state)
	current_state = new_state
	current_state.enter()
