class_name JumpingMovement
extends GroundMovement

@export var jump_force: float = 300
@export var extend_jump: bool = false

func init(_entity: Entity):
	apply_jump(_entity)

func apply_jump(entity: Entity):
	entity.velocity.y = -jump_force

func update_movement(delta: float, entity: Entity) -> void:
	if extend_jump:
		apply_jump(entity)
	super.update_movement(delta, entity)

func apply_gravity(_delta: float, _entity: Entity) -> void:
	super.apply_gravity(_delta, _entity)
