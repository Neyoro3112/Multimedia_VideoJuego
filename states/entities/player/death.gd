extends PlayerState
class_name PlayerDeath

@export var knockback_movement_component: KnockbackMovement
@export var particles_scene: PackedScene
@export var particles_position_marker: Marker2D
@onready var world_collider: CollisionShape2D = $"../../WorldCollider"

func enter():
	player.movement_component = knockback_movement_component
	knockback_movement_component.init(player)
	player.animation_controller.update_animation(PlayerAnimations.Death)
	player.movement_fsm.paused = true
	player.set_collision_layer_value(7, false)

func physics_update(delta: float):
	player.update_physics(delta)


func _on_hurt_box_hit(_dmg: int, healthComponent: HealthComponent, hitbox: HitBox) -> void:
	if healthComponent.is_alive: return
	knockback_movement_component.setup_knockback(hitbox, player)
	transitioned.emit(PlayerStates.Action.death)

func emit_death_particles():
	var particles := particles_scene.instantiate() as Node2D
	particles.global_position = particles_position_marker.global_position
	player.get_parent().add_child(particles)
