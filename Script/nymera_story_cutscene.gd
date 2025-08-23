extends Node2D

@onready var charName = $"CanvasLayer/Center Buttom/CharName"
@onready var phase = $"CanvasLayer/Center Buttom/Phase"
@onready var nextButton: Button = $"CanvasLayer/Center Buttom/Button"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var timer: Timer = $Timer
var autoplay = false
#typing writer
var visible_character = 0
@onready var audio = $AudioStreamPlayer

var prev = 0
var curr = 0
var end = 10

func _ready() -> void:
	
	$AnimationPlayer.play("1st Scene")
	curr = 1
	prev = 1

func _process(delta: float) -> void:
	if visible_character != phase.visible_characters:
		visible_character = phase.visible_characters
		AudioManager.set_stream("res://SFX/keyboard-typing-one-short.mp3")
		AudioManager.play_stream()
	'''
	if autoplay == true && not animation_player.is_playing() :
		animation_player.play()
		
	elif autoplay == false && animation_player.is_playing() :
		animation_player.pause()
	'''
func pause():
	animation_player.pause()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next") && not animation_player.is_playing():
		animation_player.play()
		
func _on_next_button_pressed() -> void:
	if not animation_player.is_playing():
		animation_player.play()
		
func _on_auto_button_pressed() -> void:
	if not animation_player.is_playing():
		autoplay = true
		#animation_player.play()
	elif animation_player.is_playing():
		autoplay = false
		#animation_player.pause()

'''
func transition_scene() -> void:
	SceneTransition.play1s()
	await get_tree().create_timer(1).timeout
'''
