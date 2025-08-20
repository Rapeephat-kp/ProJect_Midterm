extends Node2D	


func _ready():
	$"../AnimationPlayer".play("RESET")
func _on_setting_button_pressed() -> void:
	$"../AnimationPlayer".play("Open")

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/choose_player.tscn")


func _on_resume_button_pressed() -> void:
	$"../AnimationPlayer".play("Close")
