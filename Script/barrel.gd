extends Node2D

@export var coin_drop_rate: float = 0.3   
var hit_count = 3
var CoinScene = preload("res://Scene/item/coin.tscn")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_hit"):
		hit_count -= 1
	
	if hit_count <= 0:
		$AnimatedSprite2D.play("broke")
		
		# สุ่มโอกาสออกเหรียญ
		if randf() < coin_drop_rate:
			spawn_coin()
		
		await get_tree().create_timer(0.5).timeout
		$AnimatedSprite2D.visible = false
		$Body_static/Body.disabled = true

func spawn_coin():
	var coin = CoinScene.instantiate()
	
	coin.global_position = global_position
	
	get_parent().add_child(coin)
