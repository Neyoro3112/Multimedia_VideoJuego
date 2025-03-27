extends CharacterBody2D

const SPEED = 60

# Called when the node enters the scene tree for the first time.
@onready var animation = $AnimationPlayer
@onready var label = $HealthLabel
@export var center_marker: Marker2D
@export var distance_from_marker: int = 300

func _ready() -> void:
	animation.play()

var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if position.x <= center_marker.position.x - distance_from_marker: direction = 1
	elif position.x >= center_marker.position.x + distance_from_marker: direction = -1
	
	animation.flip_h = direction == -1
	
	position.x += direction * SPEED * delta


func _on_health_component_health_changed(_diff: int) -> void:
	pass
