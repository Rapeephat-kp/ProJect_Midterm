extends Node2D
#UI
@onready var nymeraProfile: TextureRect = $CanvasUI/Player_show/Nymera
@onready var elendrosProfile: TextureRect = $CanvasUI/Player_show/Elendros
@onready var inventory: Node2D = $CanvasUI/Inventory/Inventory

@onready var elendros: Elendros = $"Main Character/Elendros"
@onready var nymera: Nymera = $"Main Character/Nymera"
@onready var spawn_point: Marker2D = $"spawn point"
@onready var checkpoint_ani: AnimatedSprite2D = $"End of stage 2/CheckpointAni"



func _ready() -> void:
	print(Gamemanager.get_p())
	var p_value = Gamemanager.get_p()
	if p_value == 1:
		elendrosProfile.visible = true
		nymeraProfile.visible = false
	elif p_value == 2:
		elendrosProfile.visible = false
		nymeraProfile.visible = true
	checkpoint_ani.visible = false
func _process(delta: float):
	inventory.initialize_inventory()
	

'''
func _on_collision_area_entered(area: Area2D) -> void:
	await get_tree().create_timer(0.5).timeout
	SceneTransition.change_scene("res://Scene/Stage_Scene/stage_2.tscn")
'''


func _on_fallzone_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		elendros.position = spawn_point.position
		nymera.position = spawn_point.position


func _on_checkpoint_area_entered(area: Area2D) -> void:
	checkpoint_ani.visible = true
	checkpoint_ani.play("default")
	await get_tree().create_timer(1).timeout
	SceneTransition.change_scene("res://Scene/Stage_Scene/stage_3.tscn")


func _on_interact_area_entered(area: Area2D) -> void:
	Gamemanager.set_currentScene("Stage 2")
