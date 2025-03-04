class_name HurtBox
extends Area2D


@export var damage: int
@export var knockbak: int = 0

@export var ownerCharacter: Character

func _ready():
	
	body_entered.connect(_on_body_entered)

func _on_body_entered(character: Character) -> void:
	if character != null  and character != ownerCharacter:
		character.hit(damage)
