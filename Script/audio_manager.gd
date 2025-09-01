extends Node2D

@onready var audio = $AudioStreamPlayer

func set_stream(streamPath):
	var new_stream = load(streamPath)
	audio.stream = new_stream
func play_stream():
	audio.play()

func set_and_play(streamPath):
	var new_stream = load(streamPath)
	audio.stream = new_stream
	audio.play()

func stop():
	audio.stop()
