extends Entity

var follow_marker: Marker2D = null
@export var following_entity: Entity :
	set(entity):
		following_entity = entity

@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var sprite_2d: Sprite2D = $Node2D/Sprite2D
@onready var pickup_area: Area2D = $PickupArea

func _ready():
	if not following_entity: following_entity = null
	pickup_area.set_deferred("monitoring", following_entity == null)

func get_follow_marker_from_entity() -> Marker2D:
	if not following_entity: 
		return null
	for marker in get_tree().get_nodes_in_group("follow_marker"):
		if marker.owner == following_entity:
			return marker
	return null
	
var dead: bool
func _physics_process(_delta: float):
	if not follow_marker and following_entity:
		follow_marker = get_follow_marker_from_entity()
		if not follow_marker:
			sprite_2d.visible = false
	if dead:
		point_light_2d.energy = lerp(point_light_2d.energy, 0.4, 0.5*_delta)
		velocity.y = gravity * _delta
		move_and_slide()
		if is_on_floor():
			animation_controller.update_animation("blink")
			dead = false
			
	if not following_entity: return
	
	if not following_entity.hurtbox.healthComponent.is_alive:
		following_entity = null
		follow_marker = null
		pickup_area.set_deferred("monitoring", following_entity == null)
		point_light_2d.energy = 10
		velocity.y = gravity * _delta
		move_and_slide()
		animation_controller.update_animation("fall")
		sprite_2d.visible = true
		dead = true
	elif follow_marker:
		global_position = global_position.slerp(follow_marker.global_position, 0.1)
	else:
		global_position = following_entity.global_position


func _on_pickup_area_body_entered(body: Entity) -> void:
	if following_entity or body is not Entity: return
	dead = false
	following_entity = body
	pickup_area.set_deferred("monitoring", following_entity == null)
	
