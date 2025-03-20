extends MovementComponent

func update_movement(_delta: float, _entity: Entity) -> void:
	pass

func apply_gravity(_delta: float, _entity: Entity) -> void:
	super.apply_gravity(_delta, _entity)
