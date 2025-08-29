extends Node2D


@onready var charName = $"CanvasLayer/stage cutscene/Setting_Panel_Bg/CharacterName"
@onready var phase = $"CanvasLayer/stage cutscene/Setting_Panel_Bg/Phase"
@onready var next_button: Button = $"CanvasLayer/stage cutscene/Setting_Panel_Bg/Next_Button"
@onready var autoplay_button: Button = $"CanvasLayer/stage cutscene/Setting_Panel_Bg/Autoplay_Button"
@onready var skip_button: Button = $"CanvasLayer/stage cutscene/Setting_Panel_Bg/Skip_Button"



@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var timer: Timer = $Timer
var autoplay = false
#typing writer
var visible_character = 0
@onready var audio = $AudioStreamPlayer


func _ready() -> void:
	#$AnimationPlayer.play("Nymera Scene")
	pass

func _process(delta: float) -> void:
	if visible_character != phase.visible_characters:
		visible_character = phase.visible_characters
		AudioManager.set_stream("res://SFX/keyboard-typing-one-short.mp3")
		AudioManager.play_stream()
		
	#change style of auto button
	#var style = StyleBoxTexture.new()
	#style.texture = "res://.godot/imported/Button_52x14.png-9dc596899a794d2c135512115af19ea8.ctex"
	#var button_theme = next_button.get_theme_stylebox("normal")
	if autoplay == false:
		timer.start()
		#autoplay_button.remove_theme_stylebox_override("normal")
		autoplay_button.modulate = "aaaaaa"
		#autoplay_button.add_theme_stylebox_override("normal",button_theme)
	elif autoplay == true:
		#autoplay_button.add_theme_stylebox_override("normal", style)
		autoplay_button.modulate = "626262"
		#autoplay_button.add_theme_stylebox_override("normal","e68e8f")
		#$CanvasLayer/Control/Setting_Panel_Bg/Autoplay_Button/Label.add_theme_color_override("font_color","ffffff")
func pause():
	animation_player.pause()
	if autoplay == true:
		pass
	elif autoplay == false:
		timer.start()
		
		
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next") && not animation_player.is_playing():
		animation_player.play()
		
func _on_next_button_pressed() -> void:
	if not animation_player.is_playing():
		animation_player.play()
		
func _on_auto_button_pressed() -> void:
	autoplay = not autoplay
	print(autoplay)


func _on_timer_timeout() -> void:
	print("timeout")
	animation_player.play()

func stage1_part1 ():
	animation_player.play("Stage 1 1-2 Nymera")


# Ending Scene
