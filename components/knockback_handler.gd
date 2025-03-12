# KnockbackHandler.gd
class_name KnockbackHandler
extends Node

var current_hitbox: HitBox
var knockback_direction: float
var knockback_timer: Timer
var velocity: float : get = get_knockback_velocity

func get_knockback_velocity(): 
	return knockback_direction * current_hitbox.knockbak

func _init(parent: Node, wait_time: float = 0.6):
	# Crea un Timer como hijo del nodo padre (por ejemplo, el estado)
	knockback_timer = Timer.new()
	parent.add_child(knockback_timer)
	knockback_timer.one_shot = true
	knockback_timer.wait_time = wait_time

# Configura el knockback basado en la HitBox
func setup_knockback(hitbox: HitBox, player_position: Vector2):
	current_hitbox = hitbox
	var knockback_d = (player_position.x - hitbox.global_position.x)
	knockback_direction = sign(knockback_d)
	

# Aplica el knockback en el physics_update
func apply_knockback(_delta: float, player: CharacterBody2D):
	if knockback_timer.time_left > 0:
		player.velocity.x = lerp(
			0., 
			knockback_direction * current_hitbox.knockbak, 
			knockback_timer.time_left / knockback_timer.wait_time
		)
	else:
		player.velocity.x = 0

# Inicia el temporizador de knockback
func start_knockback():
	knockback_timer.start()
