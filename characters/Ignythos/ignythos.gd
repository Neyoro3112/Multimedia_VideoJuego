extends Entity

@export var following_entity: Entity
var follow_marker: Marker2D = null
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#func _ready():
	#

func get_follow_marker_from_entity() -> Marker2D:
	var markers = following_entity.get_tree().get_nodes_in_group("follow_marker")
	if markers.size() > 0:
		return markers[0]
	return null
var dead: bool
func _physics_process(_delta: float):
	if dead:
		point_light_2d.energy = lerp(point_light_2d.energy, 0.4, 0.5*_delta)
		velocity.y = 1000 * _delta
		move_and_slide()
		if is_on_floor():
			animation_player.play("blink")
			dead = false
			
	if not following_entity: return
	if not following_entity.hurtbox.healthComponent.is_alive:
		following_entity = null
		follow_marker = null
		point_light_2d.energy = 10
		velocity.y = -1000 * _delta
		move_and_slide()
		animation_player.play("fall")
		dead = true
	elif follow_marker:
		global_position = global_position.slerp(follow_marker.global_position, 0.1)
	else:
		follow_marker = get_follow_marker_from_entity()
