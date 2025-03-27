class_name AudioGlobals
extends Node

## Son los tipos de sonidos que se podran reproducir de manera global en el juego.
enum TYPES {
	UI_SELECTION
}

static var master_volume: float = 1. :
	set(value):
		set_bus_volume(clampf(value, 0, 1), AudioBuses.Master)
static var music_volume: float = 1. :
	set(value):
		set_bus_volume(clampf(value, 0, 1), AudioBuses.Main.Music)
static var sfx_volume: float = 1. :
	set(value):
		set_bus_volume(clampf(value, 0, 1), AudioBuses.Main.SFX)

static func set_bus_volume(value: float, bus: StringName):
	var bus_idx := AudioServer.get_bus_index(bus)
	if bus_idx == -1: push_error("Bus: %s not found." % bus)
	
	AudioServer.set_bus_volume_linear(bus_idx, value)
	
static func set_bus_send(source_bus: String, destination_bus: String) -> void:
	var source_index = AudioServer.get_bus_index(source_bus)
	var dest_index = AudioServer.get_bus_index(destination_bus)
	if source_index == -1 or dest_index == -1: return
	AudioServer.set_bus_send(source_index, destination_bus)

static func reset_main_buses_send():
	set_main_buses_effect_send(AudioBuses.Master)

static func set_main_buses_effect_send(effect: String):
	for bus in AudioBuses.Main.values():
		set_bus_send(bus, effect)
