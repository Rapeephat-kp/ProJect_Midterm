extends Node2D

#UI
@onready var nymeraProfile: TextureRect = $CanvasUI/Player_show/Nymera
@onready var elendrosProfile: TextureRect = $CanvasUI/Player_show/Elendros
@onready var inventory: Node2D = $CanvasUI/Inventory/Inventory
@onready var coin_amount: Label = $CanvasUI/Player_show/Coins/Coin_Amount

@onready var UI: CanvasLayer = $CanvasUI

#Mission
@onready var bridge: TileMapLayer = $TileMap/Bridge
var logs_quantity_require = 3


@onready var elendros: Elendros = $"Main Character/Elendros"
@onready var nymera: Nymera = $"Main Character/Nymera"
@onready var spawn_point: Marker2D = $"spawn point"

@onready var left_bound: Label = $HintLabel/LeftBound

var player

func _ready() -> void:
	Gamemanager.set_scene_spawn("stage_3")
	bridge.collision_enabled = false
	bridge.modulate = "ffffff39"
	$"Start stage 3/CheckpointAni".play("default")
	print(Gamemanager.get_p())
	var p_value = Gamemanager.get_p()
	if p_value == 1:
		player = elendros
		elendrosProfile.visible = true
		nymeraProfile.visible = false
	elif p_value == 2:
		player = nymera
		elendrosProfile.visible = false
		nymeraProfile.visible = true
	UI.visible = true
	player.position = spawn_point.position
	
func _process(delta: float):
	inventory.refresh_inventory()
	coin_amount.text = str(Gamemanager.get_coin())
	missionCheck()



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
	if area.is_in_group("Player"):
		Gamemanager.set_currentScene("Stage 3")



func _on_water_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player.position = $"spawn point".position
		Gamemanager.set_player_health(-20)




func _on_left_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		#$"map bounds/left/Label".visible = true
		left_bound.visible = true


func _on_left_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		#$"map bounds/left/Label".visible = false
		left_bound.visible = false

func _on_right_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		await get_tree().create_timer(0.5).timeout
		SceneTransition.change_scene("res://Scene/Stage_Scene/stage_4.tscn")

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
		PlayerInventory.remove_item("Logs",logs_quantity_require)
	#mission fail
	elif missionCheck() == false:
		print("fail")


func _on_interact_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		Gamemanager.set_currentScene("Stage 3")
