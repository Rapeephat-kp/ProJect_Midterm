extends Node2D

func _ready():
	Gamemanager.all_reset()
	PlayerInventory.inventory = { }
	AudioManager.set_and_play_music("res://BG Music/Main Menu.ogg")
	
func _on_button_pressed():
	SceneTransition.change_scene("res://Scene/choose_player.tscn")
	AudioManager.stop_music()
	AudioManager.play_press_sfx()
