extends Node2D

var click_check = false

func _on_hp_potion_pressed() -> void:
	var cam = $Control/HP_Potion/Camera2D
	click_check = !click_check   
	cam.enabled = click_check
	$CanvasLayer.visible = !click_check
	AudioManager.play_press_sfx()
	
func _on_max_hp_potion_pressed() -> void:
	var cam = $Control/Max_HP_Potion/Camera2D
	click_check = !click_check  
	cam.enabled = click_check
	$CanvasLayer.visible = !click_check
	

func _on_hp_buy_pressed() -> void:
	if Gamemanager.get_coin() >= 100:
		PlayerInventory.add_item("Healing Potion",1)
		Gamemanager.set_coin(-100)
		
func _on_max_hp_buy_pressed() -> void:
	if Gamemanager.get_coin() >= 350:
		PlayerInventory.add_item("Increase Max Hp Potion",1)
		Gamemanager.set_coin(-350)
		
func _on_exit_pressed() -> void:
	pass
	#$".".visible = false
