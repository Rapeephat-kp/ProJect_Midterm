extends Node2D

@onready var hitbox: CollisionShape2D = $Sprite2D/Area2D/CollisionShape2D
@onready var sprite: AnimatedSprite2D = $Sprite2D

@export var fall_speed: float = 300.0      
@export var telegraph_time: float = 1.0    
@export var damage_time: float = 10    
@export var ground_y: float = 1000.0         

var active = false

func _ready():
	$Sprite2D.play("Move")
	hitbox.disabled = true	
	sprite.modulate.a = 0.4   
	await get_tree().create_timer(telegraph_time).timeout
	
	active = true
	hitbox.disabled = false
	sprite.modulate.a = 1.0


func _process(delta):
	if active:
		position.y += fall_speed * delta
		#if position.y >= ground_y:
			#queue_free()

				

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		Gamemanager.set_player_health(-10)
