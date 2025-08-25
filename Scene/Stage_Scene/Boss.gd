extends CharacterBody2D
var player
@export var num_attacks: int = 3
@export var telegraph_time: float = 1.0
@export var attack_area_scene: PackedScene = preload("res://Scene/Monster_Scene/Boss_attack/boss_attack.tscn")
@export var attack_interval: float = 2.0  

func _ready():
	player = $"../Nymera"
	print("Boss ready")
	start_attack_cycle()
	$AnimatedSprite2D.play("Idle")
	
func random_multi_attack():
	for i in range(num_attacks):
		var pos = player.global_position - $AnimatedSprite2D.global_position
		var warning = attack_area_scene.instantiate()
		warning.global_position = pos
		add_child(warning)
		warning.show_warning(telegraph_time)
		
func start_attack_cycle():
	random_multi_attack()
	await get_tree().create_timer(attack_interval).timeout
	start_attack_cycle()
