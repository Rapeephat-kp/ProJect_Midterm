extends Node2D

@onready var audio = $AudioStreamPlayer

func set_stream(streamPath):
	var new_stream = load(streamPath)
	audio.stream = new_stream
func play_stream():
	audio.play()
