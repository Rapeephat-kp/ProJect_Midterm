extends Node2D
@onready var info_time: Label = $CanvasLayer/Control/Finish_Detail/text/play_time/info
@onready var elendros_profile: Sprite2D = $CanvasLayer/Control/Player_profile/PlayerProflie/Elendros_Profile
@onready var nymera_profile: Sprite2D = $CanvasLayer/Control/Player_profile/PlayerProflie/Nymera_Profile
@onready var info_death: Label = $CanvasLayer/Control/Finish_Detail/text/Deaths/info
@onready var achievement_1: Panel = $CanvasLayer/Control/Finish_Detail/achievement1
@onready var achievement_2: Panel = $CanvasLayer/Control/Finish_Detail/achievement2

var player_check = 0


func _ready() -> void:
	player_check = Gamemanager.get_p()
	info_time.text = Gamemanager.get_played_time_string()
	info_death.text = str(Gamemanager.get_player_death_time())
	if player_check == 1:
		elendros_profile.visible = true
		nymera_profile.visible = false
	elif player_check == 2:
		elendros_profile.visible = false
		nymera_profile.visible = true
	else:
		elendros_profile.visible = false
		nymera_profile.visible = false
		
	if Gamemanager.achievement_1:
		achievement_1.modulate = "30743b"
	else :
		achievement_1.modulate = "860124"
	if Gamemanager.get_coin() >= 300:
		achievement_2.modulate = "30743b"
	else:
		achievement_2.modulate = "860124"
func _on_main_menu_pressed() -> void:
	SceneTransition.change_scene("res://Scene/main.tscn")
	AudioManager.play_press_sfx()
