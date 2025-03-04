extends State
class_name PlayerState

const IDLE = "idle"
const WALKING = "walking"
const RUNNING = "running"
const JUMPING = "jumping"
const FALLING = "falling"
const ROLLING = "rolling"
const ATTACKING = "attacking"
const KNOCKBACK = "knockback"

func check_action_pressed(action: StringName,just_pressed: bool = false):
	return Input.is_action_just_pressed(action) if just_pressed else Input.is_action_pressed(action)

@onready var player = self.owner as Player

func _ready() -> void:
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
	
func update_player_direction():
	player.direction = Input.get_axis("move_left", "move_right")
	player.check_direction()
	
func apply_movement(_delta: float, movement_speed: float = player.speed):
	update_player_direction()
	player.velocity.x = player.direction * movement_speed
	
func apply_gravity(delta: float):
	player.velocity.y += player.gravity * delta

func should_transition_to_fall():
	return FALLING if not player.is_on_floor() else ""

func should_transition_to_jump(just_pressed: bool = true):
	return (func(): 
		return JUMPING if check_action_pressed("jump", just_pressed) and player.is_on_floor() else "")
func should_transition_to_roll():
	return ROLLING if Input.is_action_just_pressed("roll") and player.is_on_floor() and player.roll_cooldown_timer.is_stopped() else ""

func should_transition_to_walk():
	return WALKING if player.direction != 0 else ""
func should_transition_to_idle():
	return IDLE if player.direction == 0 else ""

func should_transition_to_attack():
	return ATTACKING if player.is_on_floor() and Input.is_action_just_pressed("attack") else ""

func should_transition_to_run():
	return RUNNING if Input.is_action_pressed("run") and player.is_on_floor() else ""

func update_physics(delta: float, movement_speed: float = 0, pre_slide_action: Callable = Callable()):
	apply_movement(delta, movement_speed)
	apply_gravity(delta)
	if pre_slide_action.is_valid(): pre_slide_action.call()
	player.move_and_slide()
	
	# Verificaciones comunes en todos los estados
	
	
