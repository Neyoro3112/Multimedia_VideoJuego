class_name HurtBox
extends Area2D

signal hit(dmg: int, hitbox: HitBox)
signal death(dmg: int, hitbox: HitBox)

@export var healthComponent: HealthComponent


func _ready():
	
	assert(healthComponent != null, "Health component not defined in %s" % self)
	
	
	

func getHit(dmg: int, hitbox: HitBox):
	healthComponent.health -= dmg
	if not healthComponent.immortability:
		if healthComponent.health == 0:
			healthComponent.immortability = true
			death.emit(dmg, hitbox)
			return
		
		healthComponent.start_immortability_timer()
		
		hit.emit(dmg, hitbox)
