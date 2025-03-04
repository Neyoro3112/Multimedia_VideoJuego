class_name Character
extends CharacterBody2D


@export var healthComponent: HealthComponent

func _ready():
	assert(healthComponent != null, "Health component not defined in %s" % self)

func hit(dmg: int):
	healthComponent.health -= dmg
