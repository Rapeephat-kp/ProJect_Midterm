extends Node2D


@onready var charName = $"CanvasLayer/Center Buttom/CharName"
@onready var phase = $"CanvasLayer/Center Buttom/Phase"
@onready var nextButton: Button = $"CanvasLayer/Center Buttom/NextButton"
@onready var auto_button: Button = $"CanvasLayer/Center Buttom/AutoButton"
@onready var animation_player: AnimationPlayer = $AnimationPlayer


@onready var timer: Timer = $Timer
var autoplay = false
#typing writer
var visible_character = 0
@onready var audio = $AudioStreamPlayer
'''
var prev = 0
var curr = 0
var end = 10
'''
func _ready() -> void:
	$AnimationPlayer.play("Elendros Scene")
	

func _process(delta: float) -> void:
	if visible_character != phase.visible_characters:
		visible_character = phase.visible_characters
		AudioManager.set_stream("res://SFX/keyboard-typing-one-short.mp3")
		AudioManager.play_stream()
	
	#change style of auto button
	var style = StyleBoxFlat.new()
	style.bg_color = Color.html("346846db")
	if autoplay == false:
		$Timer.start()
		auto_button.remove_theme_stylebox_override("normal")
	elif autoplay == true:
		auto_button.add_theme_stylebox_override("normal", style)
	
func pause():
	animation_player.pause()
	if autoplay == true:
		pass
	elif autoplay == false:
		$Timer.start()
		
		
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next") && not animation_player.is_playing():
		animation_player.play()
		
func _on_next_button_pressed() -> void:
	if not animation_player.is_playing():
		animation_player.play()
		
func _on_auto_button_pressed() -> void:
	autoplay = not autoplay
	print(autoplay)

'''
func transition_scene() -> void:
	SceneTransition.play1s()
	await get_tree().create_timer(1).timeout
'''


func _on_timer_timeout() -> void:
	print("timeout")
	animation_player.play()
