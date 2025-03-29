class_name HumanController
extends PlayerController

var input_map: Dictionary[StringName, bool] = {}
var input_buffer: Dictionary[StringName, float] = {}
var buffer_time: float = 0.15

func _physics_process(_delta: float) -> void:
	player.direction = int(Input.get_axis("move_left", "move_right"))
	update_input_map()
	update_buffer(_delta)
func update_input_map() -> void:
	for action in PlayerActions.list:
		input_map[action] = Input.is_action_just_pressed(action)
		if input_map[action]:
			input_buffer[action] = buffer_time

func update_buffer(delta: float) -> void:
	for action in input_buffer.keys():
		if input_buffer[action] != null:
			input_buffer[action] -= delta
			if input_buffer[action] <= 0:
				input_buffer.erase(action)
				input_map[action] = false  # Opcional: se puede limpiar el input_map también.

func is_action_triggered(action: StringName):
	return input_map.get(action, false) or (input_buffer.get(action, 0) > 0)
	
func is_action_held(action: StringName):
	return Input.is_action_pressed(action)
