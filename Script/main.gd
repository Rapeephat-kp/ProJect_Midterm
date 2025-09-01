extends Node2D

func _ready():
	Gamemanager.all_reset()
	PlayerInventory.inventory = { 
		
	}
func _on_button_pressed():
	SceneTransition.change_scene("res://Scene/choose_player.tscn")
	#get_tree().change_scene_to_file("res://Scene/choose_player.tscn")
