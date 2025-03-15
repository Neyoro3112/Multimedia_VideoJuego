extends Entity
class_name Player

@export var jump_speed = 300
@export var attack_speed = 100
@export var roll_speed = 520.


@export var controller: PlayerController : set = set_controller

@onready var rollBlockinCeiling: RayCast2D = $RollCeilingRaycast



func _ready():
	animation_controller.update_side(facing_right)
	assert(controller != null, "El jugador no tiene asignado un 'controller'")
	
func set_controller(new_controller: PlayerController):
	if controller: remove_child(controller)
	controller = new_controller
	if controller.get_parent() != self:
		add_child(controller)
	controller.player = self
