class_name HurtBox
extends Area2D

signal hit(dmg: int, healthComponent: HealthComponent, hitbox: HitBox)

@export var healthComponent: HealthComponent


func _ready():
	
	assert(healthComponent != null, "Health component not defined in %s" % self)
	
	
	

func getHit(dmg: int, hitbox: HitBox) -> bool:
	healthComponent.health -= dmg
	if not healthComponent.immortability:	
		healthComponent.start_immortability_timer()
		
		hit.emit(dmg, healthComponent, hitbox)
		return true
	return false
	
