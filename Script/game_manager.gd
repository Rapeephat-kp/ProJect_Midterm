extends Node2D

class_name GameManager

var Wood = 0
var player = 2
var current_main_player_hp = 0
var coins = 450


func all_reset():
	current_main_player_hp = 0
	var coins = 0

func set_player_health(hp):
	current_main_player_hp = hp
	
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
