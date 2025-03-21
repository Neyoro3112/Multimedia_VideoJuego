extends EntityState
class_name PlayerState

@onready var player: Player = self.owner as Player

func _ready() -> void:
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
