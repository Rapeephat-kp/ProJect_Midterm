extends Node2D


@onready var sfx: AudioStreamPlayer = $SFX
@onready var sfx_2: AudioStreamPlayer = $SFX2
@onready var bg_music: AudioStreamPlayer = $"BG Music"
@onready var walk: AudioStreamPlayer = $walk

var walk_status = false
var w = 1
func _ready() -> void:
	walk.volume_db = float(30)
#SFX
func set_sfx(streamPath):
	var new_stream = load(streamPath)
	sfx.stream = new_stream
	
func play_sfx():
	sfx.play()
	
func set_and_play_sfx(streamPath):
	var new_stream = load(streamPath)
	sfx.stream = new_stream
	sfx.play()

func set_and_play_sfx_volume(streamPath,db):
	var new_stream = load(streamPath)
	sfx.stream = new_stream
	sfx.volume_db = float(db)
	sfx.play()
func stop_sfx():
	sfx.stop()
	
#Background Music
func set_music(streamPath):
	var new_stream = load(streamPath)
	bg_music.stream = new_stream
	
func play_music():
	bg_music.play()
	
func set_and_play_music(streamPath):
	var new_stream = load(streamPath)
	bg_music.stream = new_stream
	bg_music.stream.loop = true
	bg_music.play()
	
func stop_music():
	bg_music.stop()
	
func set_and_play_sfx2_volume(streamPath,db):
	var new_stream = load(streamPath)
	sfx_2.stream = new_stream
	sfx_2.volume_db = float(db)
	sfx_2.play()

func stop_sfx2():
	sfx_2.stop()
	
func set_sfx2(streamPath):
	var new_stream = load(streamPath)
	sfx_2.stream = new_stream

func play_sfx2():
	sfx_2.play()
	

func _process(delta: float) -> void:
	if walk_status == true:
		if not walk.playing:
			walk.play()
			w = 0
	else:
		#if walk.playing:
			#walk.stop()
			#w = 1
		walk.stop()

func set_walk_status(status):
	walk_status = status
	await get_tree().create_timer(5).timeout
	
func set_walk_sfx(curScene):
	if curScene == "Stage 5" || curScene == "Stage 6":
		walk.stream = load("res://SFX/InScene/running-in cave.ogg")
	else:
		walk.stream = load("res://SFX/InScene/running-on-gravel.ogg")
#func play_walk_sfx(curscene):
	#walk.play()
	#walk.stream.loop = true
	#
func stop_walk_sfx():
	walk.stop()

func play_press_sfx():
	AudioManager.set_and_play_sfx("res://SFX/InScene/button-press.ogg")
