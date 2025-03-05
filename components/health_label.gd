extends Label


func _on_health_health_changed(current: int,_diff: int) -> void:
	text = str(current)
