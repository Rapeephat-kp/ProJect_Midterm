extends Node2D

@export var coin_drop_rate: float = 0.4  
var hit_count = 3
var Box_break = false
var CoinScene = preload("res://Scene/item/coin.tscn")
var xAxis = $".".position.x
@onready var timer: Timer = $Timer

	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_hit"):
		hit_count -= 1
		AudioManager.set_and_play_sfx_volume("res://SFX/InScene/breaking barrel.mp3",-10)
		'''
		var tween = create_tween()
		var strength = 10
		var duration = 0.05

		tween.tween_property(self, "position", position + Vector2(strength, 0), duration).as_relative()
		tween.tween_property(self, "position", position - Vector2(strength, 0), duration).as_relative()
		tween.tween_property(self, "position", position, duration)		
		tween.finished
		'''
	if hit_count <= 0 && !Box_break:
		
		$AnimatedSprite2D.play("broke")
		AudioManager.set_and_play_sfx_volume("res://SFX/InScene/breaking barrel.mp3",-10)
		# สุ่มโอกาสออกเหรียญ
		if randf() < coin_drop_rate:
			spawn_coin()
			AudioManager.set_and_play_sfx("res://SFX/InScene/drop coin 1.mp3")
		Box_break = true
		
		await get_tree().create_timer(0.5).timeout
		$AnimatedSprite2D.visible = false
		$Body_static/Body.disabled = true
		queue_free()
func spawn_coin():
	var coin = CoinScene.instantiate()
	
	coin.global_position = global_position
	
	get_parent().add_child(coin)
	
var original_pos = position
func shake():
	pass
func _on_timer_timeout() -> void:
	pass # Replace with function body.
