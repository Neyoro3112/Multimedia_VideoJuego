class_name AudioGlobals
extends Node

## Son los tipos de sonidos que se podran reproducir de manera global en el juego.
enum TYPES {
	UI_SELECTION
}


var music_volume: float
var sfx_volume: float

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
