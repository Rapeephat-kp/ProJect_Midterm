extends Node2D	

var status = 0
#UI
@onready var setting_label: Label = $"../Setting_Button/Label"
@onready var achievement_label: Label = $"../Achievement_Button/Label"
@onready var achievement_ui: Control = $"../Achievement_UI"

func _ready():
	$"../AnimationPlayer".play("RESET")
	setting_label.visible = false
	achievement_label.visible = false
	achievement_ui.visible = false
func _on_setting_button_pressed() -> void:
	if status != 1:
		status = 1
		$"../AnimationPlayer".play("Open")
	AudioManager.play_press_sfx()
func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/main.tscn")


func _on_resume_button_pressed() -> void:
	status = 0
	$"../AnimationPlayer".play("Close")
	AudioManager.play_press_sfx()


func _on_achievement_button_button_down() -> void:
	achievement_ui.visible = true

func _on_achievement_button_button_up() -> void:
	achievement_ui.visible = false


func _on_setting_button_mouse_entered() -> void:
	setting_label.visible = true


func _on_setting_button_mouse_exited() -> void:
	setting_label.visible = false


func _on_achievement_button_mouse_entered() -> void:
	achievement_label.visible = true


func _on_achievement_button_mouse_exited() -> void:
	achievement_label.visible = false
