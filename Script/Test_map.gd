extends Node2D

@export var item_scene: PackedScene
@export var monster_scenes: Array[PackedScene]   # เก็บมอนสเตอร์หลายชนิด
@onready var player

var spawn_points: Array = []         
var mon_spawn_points: Array = []      
var free_mon_points: Array = []       
var used_mon_points: Dictionary = {}  # mapping: monster_node -> point
var hp_phase = 70
var current_item: Node = null   


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
		
	for marker in $SpawnMarkers.get_children():
		if marker is Marker2D:
			spawn_points.append(marker.global_position)

	for marker in $MonstersSpawnMarkers.get_children():
		if marker is Marker2D:
			mon_spawn_points.append(marker.global_position)
			free_mon_points.append(marker.global_position) 
	
	spawn_random_item()
	

func spawn_random_item():
	if spawn_points.is_empty():
		return
	
	var pos = spawn_points.pick_random()
	var item = item_scene.instantiate()
	item.global_position = pos
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
	add_child(monster)
	
	used_mon_points[monster] = pos
	free_mon_points.erase(pos)
	
	monster.tree_exited.connect(func():
		if monster in used_mon_points:
			var freed_pos = used_mon_points[monster]
			free_mon_points.append(freed_pos)
			used_mon_points.erase(monster)
	)


func _process(delta: float):
	$CanvasUI/Inventory/Inventory.initialize_inventory()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/stage_1_in_the_city.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/store.tscn")
