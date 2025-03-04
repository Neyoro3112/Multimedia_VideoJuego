extends Character
class_name Player

@export var animation_controller: AnimationController
@export var jump_time := 0.3
@export var roll_time := 0.5
@export var facing_right = true
@export var speed = 200
@export var run_speed = 300
@export var jump_speed = 300
@export var attack_speed = 100
@export var roll_speed = 520.
@export var gravity = 1800

@onready var roll_cooldown_timer: Timer = $RollCooldownTimer
@onready var rollBlockinCeiling: RayCast2D = $RollCeilingRaycast

@export var locked_side: bool = false

func set_locked_side(value: bool):
	locked_side = value

var last_rolling_state = false

var direction = 0


func _ready():
	
	animation_controller.update_side(facing_right)
	$HealthLabel.text = str(healthComponent.health)
	

func check_direction():
	if locked_side: return
	var new_facing_right = direction > 0 if direction != 0 else facing_right
	if new_facing_right != facing_right:
		facing_right = new_facing_right
		animation_controller.update_side(facing_right)
	
	


func _on_health_health_changed(_diff: int) -> void:
	$HealthLabel.text = str(healthComponent.health)
