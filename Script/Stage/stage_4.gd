extends Node2D

var player
func _ready() -> void:
	
	print(Gamemanager.get_p())
	var p_value = Gamemanager.get_p()
	
	if p_value == 1:
		player = $"Main Character/Nymera"
		$CanvasUI/Player_show/Elendros.visible = true
		$CanvasUI/Player_show/Nymera.visible = false
	elif p_value == 2:
		player = $"Main Character/Elendros"
		$CanvasUI/Player_show/Elendros.visible = false
		$CanvasUI/Player_show/Nymera.visible = true
	player.position = $Spawn.position
func _process(delta: float):
	$CanvasUI/Inventory/Inventory.refresh_inventory()
	$CanvasUI/Player_show/Coins/Coin_Amount.text = str(Gamemanager.get_coin())
	


func _on_water_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player.position = $Spawn.position
		Gamemanager.set_player_health(-20)


func _on_next_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scene/Stage_Scene/stage_5.tscn")
