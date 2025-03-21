class_name EntityState
extends State

@onready var entity: Entity = owner as Entity

func get_animation_checks() -> Dictionary[String, bool]:
	return {}

func update_animation(start: bool = false):
	var animation_checks = get_animation_checks()
	for animation in animation_checks:
		if animation_checks[animation]:
			entity.animation_controller.update_animation(animation, start)
			return
