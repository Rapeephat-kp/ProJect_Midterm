extends Node2D
@onready var info_time: Label = $CanvasLayer/Control/Finish_Detail/text/play_time/info
@onready var elendros_profile: Sprite2D = $CanvasLayer/Control/Player_profile/PlayerProflie/Elendros_Profile
@onready var nymera_profile: Sprite2D = $CanvasLayer/Control/Player_profile/PlayerProflie/Nymera_Profile

var player_check = 0


func _ready() -> void:
	Gamemanager.pause_timer()
	player_check = Gamemanager.get_p()
	info_time.text = Gamemanager.get_played_time_string()
	if player_check == 1:
		elendros_profile.visible = true
		nymera_profile.visible = false
	elif player_check == 2:
		elendros_profile.visible = false
		nymera_profile.visible = true
	else:
		elendros_profile.visible = false
		nymera_profile.visible = false
func _on_main_menu_pressed() -> void:
	SceneTransition.change_scene("res://Scene/main.tscn")
