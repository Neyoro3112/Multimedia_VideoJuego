class_name HurtBox
extends Area2D


@export var healthComponent: HealthComponent

func _ready():
	assert(healthComponent != null, "Health component not defined in %s" % self)

func hit(dmg: int):
	healthComponent.health -= dmg
