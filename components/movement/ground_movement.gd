extends MovementComponent
class_name GroundMovement

@export var speed_multiplier: float = 1.
@export var speed: float = 160

func update_movement(_delta: float, _entity: Entity) -> void:
	_entity.velocity.x = _entity.direction * speed * speed_multiplier
	apply_gravity(_delta, _entity)

func apply_gravity(_delta: float, _entity: Entity) -> void:
	super.apply_gravity(_delta, _entity)
