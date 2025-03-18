class_name EnemyController
extends BaseController

var enemy: Enemy

var actions: Dictionary[StringName, bool]

func is_action_triggered(_action: StringName) -> bool:
	return actions.get(_action, false)

#func _physics_process(_delta: float) -> void:
	

func _on_detection_area_body_entered(body: Entity) -> void:
	enemy.target = body
	actions[EnemyActions.chase] = true
