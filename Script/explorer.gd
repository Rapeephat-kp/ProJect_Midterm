extends CharacterBody2D

@onready var explorer_flip_l: AnimatedSprite2D = $ExplorerFlipL
@onready var explorer_flip_r: AnimatedSprite2D = $ExplorerFlipR
@onready var buttton_guide: Sprite2D = $"../buttton guide"

var gravity : float = 30


func _ready() -> void:
	explorer_flip_l.play("idle")
	buttton_guide.visible = false
	
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity

func _on_detect_zone_l_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		explorer_flip_l.play("greeting")
		explorer_flip_l.visible = true
		explorer_flip_r.visible = false


func _on_detect_zone_l_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		explorer_flip_l.play("idle")
		

func _on_detect_zone_r_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		explorer_flip_r.play("greeting")
		explorer_flip_r.visible = true
		explorer_flip_l.visible = false
		
func _on_detect_zone_r_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		explorer_flip_r.play("idle")


func _on_interact_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		buttton_guide.visible = true

func _on_interact_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		buttton_guide.visible = false
	
