extends MovementComponent

func init(_entity: Entity):
	pass

func update_movement(_delta: float, _entity: Entity) -> void:
	pass

func apply_gravity(_delta: float, _entity: Entity) -> void:
	super.apply_gravity(_delta, _entity)
