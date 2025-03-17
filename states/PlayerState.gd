extends State
class_name PlayerState

@onready var player: Player = self.owner as Player

func _ready() -> void:
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")

func get_animation_checks() -> Dictionary[String, bool]:
	return {}

func update_animation(start: bool = false):
	var animation_checks = get_animation_checks()
	for animation in animation_checks:
		if animation_checks[animation]:
			player.animation_controller.update_animation(animation, start)
			return
		

func update_physics(delta: float, movement_speed: float = 0, pre_slide_action: Callable = Callable()):
	player.move(movement_speed)
	player.apply_gravity(delta)
	if pre_slide_action.is_valid(): pre_slide_action.call()
	player.move_and_slide()
