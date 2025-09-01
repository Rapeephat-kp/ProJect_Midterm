extends Node2D

func _on_respawn_pressed() -> void:
	var get_scene = Gamemanager.get_scene_spawn_point()
	Gamemanager.spawn_detail_load()
	SceneTransition.change_scene("res://Scene/Stage_Scene/" + get_scene + ".tscn")
	
func _on_main_menu_pressed() -> void:
	SceneTransition.change_scene("res://Scene/main.tscn")
