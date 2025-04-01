extends Camera2D

@export_group("Target")
@export var player: Player

@export_group("Shake Config")
@export var max_shake: float = 10.
@export var shake_fade: float = 10.

var shake_strength: float = 0.

func _ready():
	player.hurtbox.hit.connect(trigger_shake)

func trigger_shake(_dmg: int, _healthComponent: HealthComponent, _hitbox: HitBox) -> void:
	shake_strength = max_shake

func _process(_delta: float):
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0., shake_fade * _delta)
		offset = Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
	if player:
		global_position = player.global_position
