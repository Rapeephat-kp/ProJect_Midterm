extends Node2D

var player
func _ready() -> void:
	Gamemanager.set_day_state(false)
	Gamemanager.set_currentScene("Stage 4")
	print(Gamemanager.get_p())
	var p_value = Gamemanager.get_p()
	
	if p_value == 1:
		player = $"Main Character/Elendros"
		$CanvasUI/Player_show/Elendros.visible = true
		$CanvasUI/Player_show/Nymera.visible = false
	elif p_value == 2:
		player = $"Main Character/Nymera"
		$CanvasUI/Player_show/Elendros.visible = false
		$CanvasUI/Player_show/Nymera.visible = true
		
	player.position = $Spawn.position
	AudioManager.set_and_play_music("res://BG Music/Bg Stage4.ogg")
func _process(delta: float):
	$CanvasUI/Inventory/Inventory.refresh_inventory()
	$CanvasUI/Player_show/Coins/Coin_Amount.text = str(Gamemanager.get_coin())
	


func _on_water_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player.position = $Spawn.position
		Gamemanager.set_player_health(-20)


func _on_next_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		SceneTransition.change_scene("res://Scene/Stage_Scene/stage_5.tscn")


func _on_interact_mer_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		Gamemanager.set_currentScene("Stage 4")


func _on_interact_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		Gamemanager.set_currentScene("Stage 4")
