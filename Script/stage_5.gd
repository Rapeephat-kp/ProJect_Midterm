extends Node2D


func _ready() -> void:
	$CanvasUI/Buff_Debuff_Status/Info_buff.connect("mouse_entered", Callable(self, "_on_button_hovered"))
	$CanvasUI/Buff_Debuff_Status/Info_buff.connect("mouse_exited", Callable(self, "_on_button_unhovered"))
	PlayerInventory.add_item("Healing Potion", 1)
	$CanvasUI/Player_show/Elendros.visible = true
	$CanvasUI/Player_show/Nymera.visible = false
	print(Gamemanager.get_p())
	var p_value = Gamemanager.get_p()
	if p_value == 1:
		$CanvasUI/Player_show/Elendros.visible = true
		$CanvasUI/Player_show/Nymera.visible = false
	elif p_value == 2:
		$CanvasUI/Player_show/Elendros.visible = false
		$CanvasUI/Player_show/Nymera.visible = true
func _process(delta: float):
	$CanvasUI/Inventory/Inventory.refresh_inventory()
	$CanvasUI/Player_show/Coins/Coin_Amount.text = str(Gamemanager.get_coin())
	if $"Main Character/Nymera".get_infected() || $"Main Character/Elendros".get_infected():
		$CanvasUI/Buff_Debuff_Status/Name.text = "poisoned"
		$CanvasUI/Buff_Debuff_Status/Name/Info.text = "your hp will decrease for a while..." 
	elif Gamemanager.get_player_buff():
		$CanvasUI/Buff_Debuff_Status/Name.text = "Poison Immunity"
		$CanvasUI/Buff_Debuff_Status/Name/Info.text = "Immune to the poison !!!" 
func _on_button_hovered():
	if Gamemanager.get_player_buff() || $"Main Character/Nymera".get_infected() || $"Main Character/Elendros".get_infected():
		$CanvasUI/Buff_Debuff_Status/Panel.visible = true
		$CanvasUI/Buff_Debuff_Status/Name.visible = true
func _on_button_unhovered():
	$CanvasUI/Buff_Debuff_Status/Panel.visible = true
	$CanvasUI/Buff_Debuff_Status/Name.visible = true
	
