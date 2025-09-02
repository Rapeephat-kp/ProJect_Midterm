extends Node2D
var button_check = true
var player
func _ready() -> void:
	Gamemanager.set_day_state(true)
	Gamemanager.set_currentScene("Stage 5")
	Gamemanager.set_scene_spawn("stage_5")
	#PlayerInventory.add_item("Healing Potion", 1) 
	#PlayerInventory.add_item("Antidote Potion", 1)
	$CanvasUI/Player_show/Elendros.visible = true
	$CanvasUI/Player_show/Nymera.visible = false
	#print(Gamemanager.get_p())
	var p_value = Gamemanager.get_p()
	if p_value == 1:
		$CanvasUI/Player_show/Elendros.visible = true
		$CanvasUI/Player_show/Nymera.visible = false
		player = $"Main Character/Elendros"
	elif p_value == 2:
		$CanvasUI/Player_show/Elendros.visible = false
		$CanvasUI/Player_show/Nymera.visible = true
		player = $"Main Character/Nymera"
		
	player.position = $Spawn.position
	AudioManager.set_and_play_music("res://BG Music/Bg Stage5-1.ogg")
func _process(delta: float):
	$CanvasUI/Inventory/Inventory.refresh_inventory()
	$CanvasUI/Player_show/Coins/Coin_Amount.text = str(Gamemanager.get_coin())
	if Gamemanager.get_player_buff():
		#print("in2")
		$CanvasUI/Buff_Debuff_Status.visible = true
		$CanvasUI/Buff_Debuff_Status/Debuff.visible = false
		$CanvasUI/Buff_Debuff_Status/Buff.visible = true
		$CanvasUI/Buff_Debuff_Status/Info_buff.visible = true
		$CanvasUI/Buff_Debuff_Status/Name.text = "Poison Immunity"
		$CanvasUI/Buff_Debuff_Status/Name/Info.text = "Immune to the poison !!!" 
	elif  Gamemanager.get_player_debuff() && !Gamemanager.get_player_buff():
		#print("in1")
		$CanvasUI/Buff_Debuff_Status.visible = true
		$CanvasUI/Buff_Debuff_Status/Debuff.visible = true
		$CanvasUI/Buff_Debuff_Status/Buff.visible = false
		$CanvasUI/Buff_Debuff_Status/Info_buff.visible = true
		$CanvasUI/Buff_Debuff_Status/Name.text = "poisoned"
		$CanvasUI/Buff_Debuff_Status/Name/Info.text = "your hp will decrease for a while..." 
		
	else:
		$CanvasUI/Buff_Debuff_Status.visible = false
		$CanvasUI/Buff_Debuff_Status/Debuff.visible = false
		$CanvasUI/Buff_Debuff_Status/Buff.visible = false
		$CanvasUI/Buff_Debuff_Status/Info_buff.visible = false
		
func _on_info_buff_pressed() -> void:
	#print("in_func")
	if Gamemanager.get_player_debuff() || Gamemanager.get_player_buff():
		#print("Hovered: Show Panel")
		$CanvasUI/Buff_Debuff_Status/Panel.visible = button_check
		$CanvasUI/Buff_Debuff_Status/Name.visible = button_check
		button_check = !button_check
	AudioManager.play_press_sfx()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player.set_in_fog(true)
		#print("in")

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player.set_in_fog(false)
		#print("out")


func _on_next_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		await get_tree().create_timer(0.5).timeout
		SceneTransition.change_scene("res://Scene/Stage_Scene/stage_6.tscn")
	#get_tree().change_scene_to_file("res://Scene/Stage_Scene/stage_6.tscn")


func _on_interact_mer_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		Gamemanager.set_currentScene("Stage 5")


func _on_interact_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		Gamemanager.set_currentScene("Stage 5")
