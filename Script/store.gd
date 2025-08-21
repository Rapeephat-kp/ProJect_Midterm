extends Node2D

var click_check = false

func _on_hp_potion_pressed() -> void:
	var cam = $Control/HP_Potion/Camera2D
	click_check = !click_check   
	cam.enabled = click_check
	$Control/Default.visible = !click_check
	$Control/Blur.visible = click_check
	$Control/HP_Potion/Panel.visible = click_check
func _on_max_hp_potion_pressed() -> void:
	var cam = $Control/Max_HP_Potion/Camera2D
	click_check = !click_check  
	cam.enabled = click_check
