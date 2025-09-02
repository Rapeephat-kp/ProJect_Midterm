extends Node2D

#UI
@onready var nymeraProfile: TextureRect = $CanvasUI/Player_show/Nymera
@onready var elendrosProfile: TextureRect = $CanvasUI/Player_show/Elendros
@onready var inventory: Node2D = $CanvasUI/Inventory/Inventory
@onready var coin_amount: Label = $CanvasUI/Player_show/Coins/Coin_Amount

@onready var UI: CanvasLayer = $CanvasUI





@onready var elendros: Elendros = $"Main Character/Elendros"
@onready var nymera: Nymera = $"Main Character/Nymera"
@onready var spawn_point: Marker2D = $"spawn point"

var player

func _ready() -> void:
	Gamemanager.set_day_state(true)
	Gamemanager.set_currentScene("Stage 1")
	Gamemanager.set_scene_spawn("stage_1")
	$"Guide Massage/left".visible = false
	var p_value = Gamemanager.get_p()
	if p_value == 1:
		player = elendros
		elendrosProfile.visible = true
		nymeraProfile.visible = false
	elif p_value == 2:
		player = nymera
		elendrosProfile.visible = false
		nymeraProfile.visible = true
	player.position = spawn_point.position
	UI.visible = true
	AudioManager.set_and_play_music("res://BG Music/Bg Stage1.ogg")
	#CutSceneManager.stage1_part1()
func _process(delta: float):
	inventory.refresh_inventory()
	#coin_amount.text = str(Gamemanager.get_coin())
	coin_amount.text = str(Gamemanager.get_coin())


func _on_collision_area_entered(area: Area2D) -> void:
	await get_tree().create_timer(0.5).timeout
	SceneTransition.change_scene("res://Scene/Stage_Scene/stage_2.tscn")


func _on_fallzone_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player.position = spawn_point.position


func _on_interact_1_area_entered(area: Area2D) -> void:
	Gamemanager.set_currentScene("Stage 1-1")
	print(Gamemanager.get_currentScene())

func _on_interact_2_area_entered(area: Area2D) -> void:
	Gamemanager.set_currentScene("Stage 1-2")


func _on_left_area_entered(area: Area2D) -> void:
	$"Guide Massage/left".visible = true




func _on_left_area_exited(area: Area2D) -> void:
	$"Guide Massage/left".visible = false
