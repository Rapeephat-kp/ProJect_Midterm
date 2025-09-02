extends Node2D

class_name GameManager
var Wood = 0
var player = 1
var current_main_player_hp = 100
var max_player_health = 100 
var coins = 200
var player_dmg = 15
var Boss_Hp = 100
var day_state = true
#Manage Cutscene
var currentscene = ""
var player_debuff = false
var player_buff = false

var scene_spawn_point = "stage_1"
var checkpoint_coin = 0
var checkpoint_player_hp = 100
var checkpoint_player_max_hp = 100
var checkpoint_player_damage = 15
@onready var checkpoint_item_list = { }
var player_dead_time = 0

var played_time: float = 0.0
var is_timer_running: bool = true

var achievement_1 = false
var achievement_2 = false

func _process(delta: float) -> void:
	if is_timer_running:
		played_time += delta
			
func all_reset():
	current_main_player_hp = 0
	coins = 0
	player_dmg = 15
	Boss_Hp = 100
	coins = 0
	current_main_player_hp = 0

func set_player_health(hp):
	current_main_player_hp += hp
	print(current_main_player_hp)
	print(max_player_health)
	
func get_player_health():
	return current_main_player_hp
	
func set_p(p):
	player = p
	
func get_p():
	return player

func get_coin() :
	return coins
	
func set_coin(n_coin) :
	coins += n_coin

func set_currentScene(curScene : String):
	currentscene = curScene
	
func get_currentScene():
	return currentscene
	
func get_player_dmg():
	return player_dmg
	
func get_Boss_health():
	return Boss_Hp
	
func set_Boss_Hp(HP):
	Boss_Hp += HP
	
func set_atk(atk):
	player_dmg += atk
	
func get_max_hp():
	return max_player_health

func set_max_hp(hp):
	max_player_health += hp
	
func set_player_buff(status):
	player_buff = status

func set_player_debuff(status):
	player_debuff = status
	
func get_player_buff():
	return player_buff

func get_player_debuff():
	return player_debuff

func _on_player_buff():
	player_buff = true

func set_scene_spawn(scene: String):
	scene_spawn_point = scene
	checkpoint_coin = coins
	checkpoint_player_damage = player_dmg
	checkpoint_player_hp = current_main_player_hp
	
	checkpoint_item_list = {}
	for key in PlayerInventory.inventory.keys():
		checkpoint_item_list[key] = [PlayerInventory.inventory[key][0], PlayerInventory.inventory[key][1]]

func  get_scene_spawn_point():
	return str(scene_spawn_point)

func load_checkpoint_inventory(inventory: Dictionary):
	inventory.clear()
	for key in checkpoint_item_list.keys():
		inventory[key] = [checkpoint_item_list[key][0], checkpoint_item_list[key][1]]
		
func reset_played_time():
	played_time = 0.0

func pause_timer():
	is_timer_running = false
	
func resume_timer():
	is_timer_running = true
	
func get_played_time() -> float:
	return played_time

func get_played_time_string() -> String:
	var hours = int(played_time) / 3600
	var minutes = (int(played_time) % 3600) / 60
	var seconds = int(played_time) % 60
	return "%02d hrs %02d mins %02d secs" % [hours, minutes, seconds]

func spawn_detail_load():
	current_main_player_hp = checkpoint_player_hp
	coins =  checkpoint_coin 
	player_dmg = checkpoint_player_damage
	max_player_health = checkpoint_player_max_hp
	load_checkpoint_inventory(checkpoint_item_list)
	
func set_dead_time(amount : int):
	player_dead_time += amount
	
func get_player_death_time():
	return  player_dead_time
	
func reset_dead_time():
	player_dead_time = 0
	
func reset_all():
	reset_dead_time()
	current_main_player_hp = 0
	max_player_health = 100 
	coins = 200
	player_dmg = 15
	Boss_Hp = 100
	currentscene = ""
	player_debuff = false
	player_buff = false
	scene_spawn_point = "stage_1"
	checkpoint_coin = 0
	checkpoint_player_hp = 100
	checkpoint_player_max_hp = 100
	checkpoint_player_damage = 15
	checkpoint_item_list = { }
	player_dead_time = 0
	played_time = 0.0
	is_timer_running = true
	achievement_1 = true
	achievement_2 = true

func set_day_state(state: bool):
	day_state = state

func get_day_state():
	return day_state
