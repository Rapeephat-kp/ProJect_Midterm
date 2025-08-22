extends Node2D	

var status = 0

func _ready():
	$"../AnimationPlayer".play("RESET")

func _on_setting_button_pressed() -> void:
	if status != 1:
		status = 1
		$"../AnimationPlayer".play("Open")

func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/main.tscn")


func _on_resume_button_pressed() -> void:
	status = 0
	$"../AnimationPlayer".play("Close")
