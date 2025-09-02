extends Node2D

@onready var canva = $CanvasModulate
var fade_speed: float = 0.5

@export var item_scene: PackedScene
@export var monster_scenes: Array[PackedScene]   # เก็บมอนสเตอร์หลายชนิด
@export var fall_attack: PackedScene
@onready var player
@onready var player_spawn_point: Marker2D = $SpawnPoint

var curPlayer
var gameEnd = true
var check_cut_scene_played = 1
var allow_fall_attack: bool = true

var spawn_points: Array = []         
var mon_spawn_points: Array = []      
var free_mon_points: Array = []    
var attack_spawn_point: Array = []   
var used_mon_points: Dictionary = {}  # mapping: monster_node -> point
var hp_phase = 80
var current_item: Node = null   


func _ready() -> void:
	Gamemanager.set_day_state(true)
	Gamemanager.set_currentScene("Stage 6")
	Gamemanager.set_scene_spawn("stage_6")
	#PlayerInventory.add_item("Healing Potion",5) 
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
	player.position = player_spawn_point.position
	for marker in $SpawnMarkers.get_children():
		if marker is Marker2D:
			spawn_points.append(marker.global_position)

	for marker in $MonstersSpawnMarkers.get_children():
		if marker is Marker2D:
			mon_spawn_points.append(marker.global_position)
			free_mon_points.append(marker.global_position) 
	
	for marker in $Ataack_Spawn.get_children():
		if marker is Marker2D:
			attack_spawn_point.append(marker.global_position)
	spawn_random_item()
	gameEnd = false
	AudioManager.set_and_play_music("res://BG Music/Bg Stage6.ogg")
func spawn_random_item():
	if spawn_points.is_empty():
		return
	
	var pos = spawn_points.pick_random()
	var item = item_scene.instantiate()
	item.global_position = pos
	item.add_to_group("spawned")
	add_child(item)
	current_item = item
	
	item.tree_exited.connect(_on_item_destroyed)


func _on_item_destroyed():
	# ลดเลือดบอส
	Gamemanager.set_Boss_Hp(-10)
	current_item = null
	if Gamemanager.get_Boss_health() <= hp_phase:
		spawn_monster()
		spawn_monster()
		spawn_monster()
		spawn_monster()
		hp_phase -= 30
		if hp_phase <= 0:
			hp_phase = 0 
	spawn_random_item()


func spawn_monster():
	if monster_scenes.is_empty() or free_mon_points.is_empty():
		return
	
	var monster_scene = monster_scenes.pick_random()
	var pos = free_mon_points.pick_random()
	
	var monster = monster_scene.instantiate()
	monster.global_position = pos
	monster.add_to_group("spawned")
	add_child(monster)
	
	used_mon_points[monster] = pos
	free_mon_points.erase(pos)
	
	monster.tree_exited.connect(func():
		if monster in used_mon_points:
			var freed_pos = used_mon_points[monster]
			free_mon_points.append(freed_pos)
			used_mon_points.erase(monster)
	)

func spawn_fall_attack():
	if attack_spawn_point.is_empty():
		return
		
	var pos = attack_spawn_point.pick_random() 
	var attack = fall_attack.instantiate()
	attack.global_position = pos
	attack.add_to_group("spawned")   
	add_child(attack)
	print("Fall attack spawned at: ", pos)


func _process(delta: float):
	$CanvasUI/Inventory/Inventory.refresh_inventory()
	$CanvasUI/Player_show/Coins/Coin_Amount.text = str(Gamemanager.get_coin())
	if Gamemanager.get_Boss_health() <= 0:
		# ดึงค่า color เดิมมา
		var current_color = canva.color
		
		var new_r = max(0, current_color.r - fade_speed * delta)
		var new_g = max(0, current_color.g - fade_speed * delta)
		var new_b = max(0, current_color.b - fade_speed * delta)
		
		canva.color = Color(new_r, new_g, new_b, 1.0)
		gameEnd = true
		
		end_game()
		
		
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/stage_1_in_the_city.tscn")
	AudioManager.play_press_sfx()

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/store.tscn")
	AudioManager.play_press_sfx()

func spawn_multiple_fall_attacks(amount: int):
	if not allow_fall_attack:
		return
	for i in range(amount):
		spawn_fall_attack()
	await get_tree().create_timer(2).timeout
	spawn_multiple_fall_attacks(4)
func _on_area_attack_check_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		spawn_multiple_fall_attacks(4)

func all_invisible():
	$Boss.visible = false
	$CanvasUI.visible = false
	$Torch.visible = false
	
func free_all_spawned():
	for node in get_tree().get_nodes_in_group("spawned"):
		if is_instance_valid(node):
			node.queue_free()

func stop_fall_attacks():
	allow_fall_attack = false

func end_game():
	if check_cut_scene_played != 0:
		check_cut_scene_played = 0
		all_invisible()
		free_all_spawned()
		stop_fall_attacks()
		curPlayer = Gamemanager.get_p()
		Gamemanager.pause_timer()
		CutSceneManager.game_end()
