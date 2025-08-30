extends CharacterBody2D
var player
@export var num_attacks: int = 3
@export var telegraph_time: float = 1.0
@export var attack_area_scene: PackedScene = preload("res://Scene/Monster_Scene/Boss_attack/boss_attack.tscn")
@export var attack_interval: float = 2.0  
var player_in = false


func _ready():
	if Gamemanager.get_p() == 2:
		player = $"../Main Character/Nymera"
		#print("Boss ready")
		#start_attack_cycle()
	elif Gamemanager.get_p() == 1:
		player = $"../Main Character/Elendros"
		
	$AnimatedSprite2D.play("Idle")

func random_multi_attack():
	if player_in :
		for i in range(num_attacks):
			var pos = player.global_position - $AnimatedSprite2D.global_position
			var warning = attack_area_scene.instantiate()
			warning.global_position = pos
			add_child(warning)
			warning.show_warning(telegraph_time)
		
func start_attack_cycle():
	if player_in:
		random_multi_attack()
		await get_tree().create_timer(attack_interval).timeout
		start_attack_cycle()


func _on_area_attack_check_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") && !player_in:
		$"../CanvasUI/Boss_Health_Bar".visible = true
		player_in = true
		await get_tree().create_timer(0.5).timeout
		start_attack_cycle()
