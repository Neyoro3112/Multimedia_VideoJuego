class_name Bat
extends Enemy
@onready var label: Label = $Label
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	animation_controller.set_flip_animations(FlyEnemyAnimations.flip_list)
	animation_controller.update_side(facing_right)

func _on_state_machine_transitioned(_from: State, to: State) -> void:
	if to:
		label.text = to.name
