# EnemyController.gd
class_name EnemyController
extends BaseController

@export var random_range_horizontal: Vector2 = Vector2(-125, 125)
@export var random_range_vertical: Vector2 = Vector2(-150, -75)
@export var target_attack_distance = 150

var enemy: Enemy
var actions: Dictionary[StringName, bool]


func is_action_triggered(_action: StringName) -> bool:
	return actions.get(_action, false)

# Método para seleccionar un punto aleatorio cerca del target
func select_random_point() -> Vector2:
	if enemy.target == null:
		return enemy.position
	var random_offset = Vector2(
		randf_range(random_range_horizontal.x, random_range_horizontal.y),
		randf_range(random_range_vertical.x, random_range_vertical.y)
	)
	return enemy.target.global_position + random_offset

func _physics_process(_delta: float) -> void:
	if not enemy.target: return
	actions[EnemyActions.attack] = enemy.global_position.distance_to(enemy.target.global_position) > target_attack_distance
	

func _on_detection_area_body_entered(body: Entity) -> void:
	enemy.target = body
	actions[EnemyActions.spotted] = true
