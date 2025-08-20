extends Node2D

func _ready() -> void:
	
	print(Gamemanager.get_p())
	var p_value = Gamemanager.get_p()
	if p_value == 1:
		$CanvasUI/Player_show/Elendros.visible = true
		$CanvasUI/Player_show/Nymera.visible = false
	elif p_value == 2:
		$CanvasUI/Player_show/Elendros.visible = false
		$CanvasUI/Player_show/Nymera.visible = true
func _process(delta: float):
	$CanvasUI/Inventory/Inventory.initialize_inventory()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/stage_1_in_the_city.tscn")
