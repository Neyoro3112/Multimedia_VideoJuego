class_name HitBox
extends Area2D

signal has_hit()

## Indica la cantidad de daño que causa esta hitbox
@export var damage: int

## Es el valor de empuje que puede generar esta hitbox en sus objetivo
@export var knockbak: int = 0

## Es la hurtbox del "dueño" del ataque, usada para validar ciertas condiciones cuando el ataque lo puede alcanzar a si mismo
@export var ownerHurtbox: HurtBox

## Indica el porcentaje del daño que puede hacer el ataque a su propio creador si lo puede tocar.
@export var ownerHurtBoxMultiplier: float = 0

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(hurtbox: HurtBox) -> void:
	if hurtbox == null: return
	var true_damage = damage
	if hurtbox == ownerHurtbox:
		true_damage = round(damage * ownerHurtBoxMultiplier)
	if hurtbox.is_in_group("EnemyBox") != is_in_group("EnemyBox"):
		
		if hurtbox.getHit(true_damage, self):
			has_hit.emit()
