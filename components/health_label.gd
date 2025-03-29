extends Label

@onready var health: HealthComponent = $"../Health"
func _ready():
	text = str(health.health)

func _on_health_health_changed(current: int,_diff: int) -> void:
	text = str(current)
