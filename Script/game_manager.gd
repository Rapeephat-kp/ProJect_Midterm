extends Node2D

class_name GameManager

var Wood = 0
var player = 2
var current_main_player_hp = 0
var max_player_health = 100 
var coins = 200
var player_dmg = 15
var Boss_Hp = 100
#Manage Cutscene
var currentscene = ""
var player_debuff = false
var player_buff = false


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
