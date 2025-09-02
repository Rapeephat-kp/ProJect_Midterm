extends Node2D

@onready var elendros_name_label: Label = $CanvasLayer/Control/ElendrosNameLabel
@onready var nymera_name_label: Label = $CanvasLayer/Control/NymeraNameLabel

func _ready() -> void:
	Gamemanager.reset_dead_time()
	elendros_name_label.visible = false
	nymera_name_label.visible = false

func _on_nymera_pressed() -> void:
	Gamemanager.set_p(2)
	Gamemanager.set_player_health(100)
	AudioManager.play_press_sfx()
	#print(Gamemanager.get_p())
	SceneTransition.change_scene("res://Scene/nymera_story_cutscene.tscn")
	#get_tree().change_scene_to_file("res://Scene/Map.tscn")
	#get_tree().change_scene_to_file("res://Scene/Stage_Scene/stage_1.tscn")
	#get_tree().change_scene_to_file("res://Scene/nymera_story_cutscene.tscn")
	
	
func _on_elendros_pressed() -> void:
	AudioManager.play_press_sfx()
	Gamemanager.set_p(1)
	Gamemanager.set_player_health(100)
	#print(Gamemanager.get_p())
	SceneTransition.change_scene("res://Scene/elendros_strory_cutscene.tscn")
	#get_tree().change_scene_to_file("res://Scene/elendros_strory_cutscene.tscn")
	#get_tree().change_scene_to_file("res://Scene/Stage_Scene/stage_1.tscn")


func _on_elendros_mouse_entered() -> void:
	elendros_name_label.visible = true
	AudioManager.set_and_play_sfx("res://SFX/choose charater sfx.mp3")

func _on_elendros_mouse_exited() -> void:
	elendros_name_label.visible = false
	


func _on_nymera_mouse_entered() -> void:
	nymera_name_label.visible = true
	AudioManager.set_and_play_sfx("res://SFX/choose charater sfx.mp3")

func _on_nymera_mouse_exited() -> void:
	nymera_name_label.visible = false
	
