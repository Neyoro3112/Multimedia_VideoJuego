extends EntityState
class_name PlayerState

@onready var player: Player = self.owner as Player

func _ready() -> void:
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")

func update_physics(delta: float, movement_speed: float = 0, pre_slide_action: Callable = Callable()):
	player.move(movement_speed)
	player.apply_gravity(delta)
	if pre_slide_action.is_valid(): pre_slide_action.call()
	player.move_and_slide()
