extends Node2D

class_name coin

var value = 0
var mob_types
var type
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mob_types = Array($Animated.sprite_frames.get_animation_names())
	type =  mob_types.pick_random()
	$Animated.animation = type
	$Animated.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if type == "Gold":
		value = 50
	elif type == "Silver":
		value = 35
	elif type == "Bronze":
		value = 25

func _on_area_2d_area_entered(area: Area2D) -> void:
	print(type)
	if area.is_in_group("Player"):
		Gamemanager.set_coin(value)
		queue_free()
		
