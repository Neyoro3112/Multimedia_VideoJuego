class_name RollingMovement
extends MovementComponent

var progress: float = 0 : set = set_progress
@export var roll_speed: float

func set_progress(value: float):
	progress = clamp(value, 0., 1.)

func update_movement(delta: float, entity: Entity) -> void:
	var speed = lerp(roll_speed * 0.08, roll_speed, progress)
	entity.velocity.x = speed * (entity.direction if progress == 0 else (1 if entity.facing_right else -1))
	apply_gravity(delta, entity)

func apply_gravity(_delta: float, _entity: Entity) -> void:
	super.apply_gravity(_delta, _entity)
