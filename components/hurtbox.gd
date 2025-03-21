class_name HurtBox
extends Area2D

signal hit(dmg: int, healthComponent: HealthComponent, hitbox: HitBox)

@export var healthComponent: HealthComponent
@export var active: bool = true :
	set(value):
		active = value
		set_deferred("monitorable", value)

func _ready():
	
	assert(healthComponent != null, "Health component not defined in %s" % self)
	
	
	

func getHit(dmg: int, hitbox: HitBox) -> bool:
	if not healthComponent.immortability and healthComponent.is_alive:
		healthComponent.health -= dmg
		healthComponent.start_immortability_timer()
		
		hit.emit(dmg, healthComponent, hitbox)
		return true
	return false
	
