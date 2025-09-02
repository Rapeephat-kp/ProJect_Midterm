extends Node2D
var condition_1 = false
var condition_2 = false

@onready var Fog1_size 
var player

func _ready() -> void:
	$Fog1.visible = false
	if Gamemanager.get_p() == 1:
		player = $"../Main Character/Elendros"
	else:
		player = $"../Main Character/Nymera"
	Fog1_size = $Fog1.size
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if condition_1 :
		Fog1_size += Vector2(0,delta*2)
		$Fog1.size = Fog1_size
		$Fog1/Area2D/CollisionShape2D.shape.size += Vector2(0,delta*2) * 2
		$GPUParticles2D.position += Vector2(0.0,delta*2) * 3.8
	
		
func _on_detect_1_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		condition_1 = true
		$Fog1.visible = true
		AudioManager.set_and_play_music("res://BG Music/Bg Stage5-2.ogg")
		print("in detect")
