extends Node2D

func _ready() -> void:
	AudioManager.set_and_play_music("res://BG Music/Gameover.ogg")

func _on_respawn_pressed() -> void:
	Gamemanager.set_dead_time(1)
	var get_scene = Gamemanager.get_scene_spawn_point()
	Gamemanager.spawn_detail_load()
	SceneTransition.change_scene("res://Scene/Stage_Scene/" + get_scene + ".tscn")
	AudioManager.play_press_sfx()
	
func _on_main_menu_pressed() -> void:
	Gamemanager.reset_dead_time()
	Gamemanager.reset_all()
	SceneTransition.change_scene("res://Scene/main.tscn")
	AudioManager.play_press_sfx()
