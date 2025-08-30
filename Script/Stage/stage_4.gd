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

func _process(delta: float):
	$CanvasUI/Inventory/Inventory.refresh_inventory()
	$CanvasUI/Player_show/Coins/Coin_Amount.text = str(Gamemanager.get_coin())
	$CanvasUI/Player_show/Coins/Coin_Amount2.text = str(Gamemanager.get_coin())


func _on_hp_buy_pressed() -> void:
	if Gamemanager.get_coin() >= 100:
		$CanvasUI/Inventory/Inventory.buy_item("Healing Potion", 1)
		Gamemanager.set_coin(-100)
		print("Buyyyy")

func _on_exit_pressed() -> void:
	$CanvasUI/Control.visible = false
