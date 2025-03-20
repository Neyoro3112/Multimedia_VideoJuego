class_name Enemy
extends Entity

@export var controller: EnemyController : set = set_controller
@export var detection_area: Area2D
@export var max_speed = 150
@export var max_att_speed = 150
@export var chasing_acceleration = 25
@export var attacking_acceleration = 100

@export var contact_hitbox: HitBox

var target: Entity

func set_controller(new_controller: EnemyController):
	if controller: remove_child(controller)
	controller = new_controller
	if controller.get_parent() != self:
		add_child(controller)
	controller.enemy = self
