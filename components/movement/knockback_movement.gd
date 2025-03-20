class_name KnockbackMovement
extends MovementComponent

@export var duration: float = 1 :
	set(value):
		duration = max(value, 0.001)
		
@export var do_apply_gravity: bool
@export var vertical_mutliplier: float = 1

var current_hitbox: HitBox
var velocity: float : get = get_knockback_velocity
var direction: float : 
	set(value):
		direction = sign(value)
		
var time_left: float = 0 : 
	set(value):
		time_left = clamp(value, 0., 1.)
		



func get_knockback_velocity() -> float:
	
	return direction * current_hitbox.knockbak if current_hitbox else 0.

func init(entity: Entity):
	time_left = duration
	entity.direction = -direction
	entity.velocity.y = -abs(velocity) * vertical_mutliplier

func setup_knockback(hitbox: HitBox, entity: Entity):
	current_hitbox = hitbox
	direction = (entity.global_position.x - hitbox.global_position.x)


func update_movement(delta: float, entity: Entity) -> void:
	entity.velocity.x = lerp(0.,velocity,time_left / duration)
	time_left -= delta
	
	if do_apply_gravity: apply_gravity(delta, entity)
	
func apply_gravity(delta: float, entity: Entity) -> void:
	super.apply_gravity(delta, entity)
