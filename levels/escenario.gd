extends Node2D

@onready var minimap_player = $Minimap/MinimapViewport/MinimapWorld/MinimapPlayer
@onready var player = $Player

func _process(delta):
	if player and minimap_player:
		minimap_player.position = player.position
