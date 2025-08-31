extends Node2D

@onready var hitbox: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

@export var fall_speed: float = 300.0  # ความเร็วตก
@export var telegraph_time: float = 1.0 # เวลาก่อนเริ่มตก
@export var damage_time: float = 0.3    # เวลาที่ hitbox เปิด

var active = false

func _ready():
	hitbox.disabled = true
	# เริ่มจากโปร่งใสเล็กน้อย
	sprite.modulate.a = 0.4  

	# Telegraph ก่อนเริ่มตก
	await get_tree().create_timer(telegraph_time).timeout
	active = true
	hitbox.disabled = false

func _process(delta):
	if active:
		position.y += fall_speed * delta

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		# ตรงนี้สั่งให้ player โดน damage ได้
		body.take_damage(10)
