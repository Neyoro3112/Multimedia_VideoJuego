class_name Entity
extends CharacterBody2D

@export var animation_controller: AnimationController
@export var facing_right = true
@export var locked_side: bool = false
@export var gravity = 1800
@export var movement_component: MovementComponent : set = set_movement_component

@export var hurtbox: HurtBox

var last_movement_component: MovementComponent

func set_movement_component(value: MovementComponent):
	last_movement_component = movement_component
	movement_component = value

func revert_movement_component():
	movement_component = last_movement_component


var direction = 0 : set = set_direction

func update_physics(_delta: float):
	if not movement_component: return
	movement_component.update_movement(_delta, self)
	move_and_slide()

func set_locked_side(value: bool):
	locked_side = value
func set_direction(new_direction: int):
	direction = clampi(new_direction, -1, 1)
	check_direction()
func check_direction():
	if locked_side: return
	var new_facing_right = direction > 0 if direction != 0 else facing_right
	if new_facing_right != facing_right:
		facing_right = new_facing_right
		animation_controller.update_side(facing_right)
