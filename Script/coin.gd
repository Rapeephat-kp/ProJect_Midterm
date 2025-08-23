extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mob_types = Array($Animated.sprite_frames.get_animation_names())
	$Animated.animation = mob_types.pick_random()
	$Animated.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
