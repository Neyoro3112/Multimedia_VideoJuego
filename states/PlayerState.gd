extends State
class_name PlayerState

const IDLE = "idle"
const WALKING = "walking"
const RUNNING = "running"
const JUMPING = "jumping"
const FALLING = "falling"
const ROLLING = "rolling"
const ATTACKING = "attacking"
const HIT = "hit"
const DEATH = "death"

func check_action_pressed(action: StringName,just_pressed: bool = false):
	return Input.is_action_just_pressed(action) if just_pressed else Input.is_action_pressed(action)

@onready var player = self.owner as Player

func _ready() -> void:
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")

func update_physics(delta: float, movement_speed: float = 0, pre_slide_action: Callable = Callable()):
	player.move(movement_speed)
	player.apply_gravity(delta)
	if pre_slide_action.is_valid(): pre_slide_action.call()
	player.move_and_slide()
	
	# Verificaciones comunes en todos los estados
	
	
