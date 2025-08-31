extends Node2D

#UI
@onready var nymeraProfile: TextureRect = $CanvasUI/Player_show/Nymera
@onready var elendrosProfile: TextureRect = $CanvasUI/Player_show/Elendros
@onready var inventory: Node2D = $CanvasUI/Inventory/Inventory
@onready var coin_amount: Label = $CanvasUI/Player_show/Coins/Coin_Amount

#Mission
@onready var bridge: TileMapLayer = $TileMap/Bridge
@onready var bridge_2: TileMapLayer = $TileMap/Bridge2
var logs_quantity_require = 3


@onready var elendros: Elendros = $"Main Character/Elendros"
@onready var nymera: Nymera = $"Main Character/Nymera"
@onready var spawn_point: Marker2D = $"spawn point"



func _ready() -> void:
	#Mission
	bridge.collision_enabled = false
	bridge.modulate = "ffffff39"
	bridge_2.modulate = "ffffff39"
	
	
	
	$"Start stage 3/CheckpointAni".play("default")
	#elendros.position = spawn_point.position
	#nymera.position = spawn_point.position
	print(Gamemanager.get_p())
	var p_value = Gamemanager.get_p()
	if p_value == 1:
		elendrosProfile.visible = true
		nymeraProfile.visible = false
	elif p_value == 2:
		elendrosProfile.visible = false
		nymeraProfile.visible = true
	#Bridge
	$TileMap/Bridge.enabled = true
	$TileMap/Bridge2.enabled = false
	#CutSceneManager.stage1_part1()
func _process(delta: float):
	inventory.refresh_inventory()
	coin_amount.text = str(Gamemanager.get_coin())
	missionCheck()

func _on_collision_area_entered(area: Area2D) -> void:
	await get_tree().create_timer(0.5).timeout
	SceneTransition.change_scene("res://Scene/Stage_Scene/stage_2.tscn")

'''
func _on_fallzone_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		elendros.position = spawn_point.position
		nymera.position = spawn_point.position


func _on_interact_1_area_entered(area: Area2D) -> void:
	Gamemanager.set_currentScene("Stage 1-1")
	print(Gamemanager.get_currentScene())

func _on_interact_2_area_entered(area: Area2D) -> void:
	Gamemanager.set_currentScene("Stage 1-2")
'''

func _on_interact_mer_area_entered(area: Area2D) -> void:
	Gamemanager.set_currentScene("Stage 3")



func _on_water_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		nymera.position = spawn_point.position





func _on_left_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		#$"map bounds/left/Label".visible = true
		$Label.visible = true


func _on_left_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		#$"map bounds/left/Label".visible = false
		$Label.visible = false

func _on_right_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

func missionCheck():
	if PlayerInventory.get_item_quantity("Logs") == logs_quantity_require:
		return true
	else:
		return false



func _on_build_bridge_area_entered(area: Area2D) -> void:
	#mission complete
	if missionCheck() == true:
		bridge.collision_enabled = true
		bridge.modulate = "ffffff"
		bridge_2.modulate = "ffffff"
		PlayerInventory.remove_item("Logs",logs_quantity_require)
	#mission fail
	elif missionCheck() == false:
		print("fail")
