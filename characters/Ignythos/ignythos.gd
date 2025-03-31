extends Entity

var follow_marker: Marker2D = null
@export var following_entity: Entity :
	set(entity):
		following_entity = entity
		

@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var sprite_2d: Sprite2D = $Node2D/Sprite2D
@onready var pickup_area: Area2D = $PickupArea

#func _ready():
	#

func get_follow_marker_from_entity() -> Marker2D:
	if following_entity and following_entity is Player:
		var markers = following_entity.get_tree().get_nodes_in_group("follow_marker")
		if markers.size() > 0:
			return markers[0]
	return null
var dead: bool
func _physics_process(_delta: float):
	if not follow_marker and following_entity:
		follow_marker = get_follow_marker_from_entity()
	if dead:
		point_light_2d.energy = lerp(point_light_2d.energy, 0.4, 0.5*_delta)
		velocity.y = 1000 * _delta
		move_and_slide()
		if is_on_floor():
			animation_controller.update_animation("blink")
			dead = false
			
	if not following_entity: return
	
	if not following_entity.hurtbox.healthComponent.is_alive:
		following_entity = null
		
		point_light_2d.energy = 10
		velocity.y = -1000 * _delta
		move_and_slide()
		pickup_area.monitoring = true
		animation_controller.update_animation("fall")
		sprite_2d.visible = true
		dead = true
	elif follow_marker:
		global_position = global_position.slerp(follow_marker.global_position, 0.1)
	else:
		print("Entity position")
		global_position = following_entity.global_position


func _on_pickup_area_body_entered(body: Entity) -> void:
	if following_entity or body is not Entity: return
	dead = false
	following_entity = body
	sprite_2d.visible = false
	pickup_area.monitoring = false
	follow_marker = null
	print("Entity: ", following_entity)
