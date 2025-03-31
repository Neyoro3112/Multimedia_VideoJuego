class_name IgnythosFollowMarker
extends Marker2D

func _ready():
	add_to_group("follow_marker")

func get_follow_position() -> Vector2:
	return global_position
