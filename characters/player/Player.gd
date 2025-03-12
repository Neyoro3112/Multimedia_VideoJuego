extends CharacterBody2D
class_name Player

@export var animation_controller: AnimationController
@export var facing_right = true
@export var speed = 160
@export var run_speed = 215
@export var jump_speed = 300
@export var attack_speed = 100
@export var roll_speed = 520.
@export var gravity = 1800
@export var locked_side: bool = false
@export var controller: PlayerController : set = set_controller

@onready var roll_cooldown_timer: Timer = $RollCooldownTimer
@onready var rollBlockinCeiling: RayCast2D = $RollCeilingRaycast

var direction = 0 : set = set_player_direction

func _ready():
	animation_controller.update_side(facing_right)
	assert(controller != null, "El jugador no tiene asignado un 'controller'")
	
func set_controller(new_controller: PlayerController):
	if controller: remove_child(controller)
	controller = new_controller
	if controller.get_parent() != self:
		add_child(controller)
	controller.player = self

func set_locked_side(value: bool):
	locked_side = value
	
func move(movement_speed: float = speed):
	velocity.x = direction * movement_speed
	
func apply_gravity(delta: float):
	velocity.y += gravity * delta

func set_player_direction(new_direction: int):
	direction = clampi(new_direction, -1, 1)
	check_direction()

func check_direction():
	if locked_side: return
	var new_facing_right = direction > 0 if direction != 0 else facing_right
	if new_facing_right != facing_right:
		facing_right = new_facing_right
		animation_controller.update_side(facing_right)
