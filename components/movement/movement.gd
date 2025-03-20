class_name MovementComponent
extends Resource

func init(_entity: Entity):
	pass

func update_movement(_delta: float, _entity: Entity) -> void:
	pass

func apply_gravity(_delta: float, _entity: Entity):
	_entity.velocity.y += _entity.gravity * _delta
