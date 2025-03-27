extends HSlider

func _process(_delta: float) -> void:
	AudioGlobals.music_volume = value
