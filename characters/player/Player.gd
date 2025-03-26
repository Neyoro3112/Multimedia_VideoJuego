extends Entity
class_name Player

@export var controller: PlayerController : set = set_controller

@onready var rollBlockinCeiling: RayCast2D = $RollCeilingRaycast
@onready var movement_fsm: StateMachine = $MovementFSM
@onready var action_fsm: StateMachine = $ActionFSM

func _ready():
	assert(controller != null, "El jugador no tiene asignado un 'controller'")
	animation_controller.set_flip_animations(PlayerAnimations.list)
	animation_controller.update_side(facing_right)
	
func set_controller(new_controller: PlayerController):
	if controller: remove_child(controller)
	controller = new_controller
	if controller.get_parent() != self:
		add_child(controller)
	controller.player = self
	
