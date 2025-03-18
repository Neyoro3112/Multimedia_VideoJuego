class_name Entity
extends CharacterBody2D

@export var animation_controller: AnimationController
@export var facing_right = true
@export var locked_side: bool = false
@export var speed = 160
@export var speed_multiplier: float = 1
@export var gravity = 1800
var direction = 0 : set = set_direction

func set_locked_side(value: bool):
	locked_side = value
func move(movement_speed: float = speed):
	velocity.x = direction * movement_speed * speed_multiplier
func apply_gravity(delta: float):
	velocity.y += gravity * delta
func set_direction(new_direction: int):
	direction = clampi(new_direction, -1, 1)
	check_direction()
func check_direction():
	if locked_side: return
	var new_facing_right = direction > 0 if direction != 0 else facing_right
	if new_facing_right != facing_right:
		facing_right = new_facing_right
		animation_controller.update_side(facing_right)
