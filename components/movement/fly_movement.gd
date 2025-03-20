extends MovementComponent
class_name FlyMovementComponent

@export var chasing_acceleration: float = 500
@export var max_speed: float = 200

# Se espera que el 'target_point' sea asignado externamente
var target_point: Vector2

func update_movement(_delta: float, enemy: Entity) -> void:
	if target_point == null:
		return
	# Calcula la dirección hacia el punto objetivo
	var movement_direction: Vector2 = enemy.position.direction_to(target_point)
	print("Acc: ", chasing_acceleration * _delta)
	enemy.velocity += movement_direction * chasing_acceleration * _delta
	enemy.velocity = enemy.velocity.limit_length(max_speed)
	enemy.direction = sign(enemy.velocity.x)
