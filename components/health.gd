class_name HealthComponent
extends Node

## Emite una señal cada vez que se actualiza la vida máxima del jugador
signal max_health_changed(current:int, diff: int)
signal health_changed(current:int, diff: int)
signal health_depleted
signal immortability_change(value: bool)

@export var immortability_timer: Timer



## Es la cantidad de vida máxima del jugador
@export var max_health: int : set = set_max_health, get = get_max_health

## Define si el jugador puede o no perder vida en dicho momento
@export var immortability: bool = false : set = set_immortality, get = get_immortality

## Es la cantidad de vida actual del jugador
@onready var health: int = max_health : set = set_health, get = get_health

var is_alive: bool : get = get_is_alive

func get_is_alive(): 
	return health>0

func _ready():
	if immortability_timer == null: immortability_timer = $Timer
	if immortability_timer:
		immortability_timer.one_shot = true
		immortability_timer.autostart = false
		
		immortability_timer.timeout.connect(disable_immortability)

func set_immortability(value: bool):
	immortability = value
	immortability_change.emit(immortability)
	
	
func disable_immortability():
	immortability = false
	

func start_immortability_timer():
	if !immortability_timer: 
		print("Immortability timer is: ", immortability_timer)
		return
	immortability = true
	immortability_timer.start()

func set_max_health(value: int):
	
	var clamped = maxi(1, value)
	
	if not clamped == max_health:
		var diff = clamped - max_health
		max_health = clamped
		max_health_changed.emit(max_health, diff)
		
		if health > max_health:
			health = max_health
	
func get_max_health() -> int:
	return max_health

func set_immortality(value: bool):
	immortability = value

func get_immortality() -> bool:
	return immortability
	
func set_health(value: int):
	var clamped = clampi(value, 0, max_health)
	if immortability: 
		return
	
	if clamped != health:
		var diff = clamped - health
		health = clamped
		health_changed.emit(health, diff)
		
		if health == 0:
			health_depleted.emit()
	
func get_health() -> int:
	return health
