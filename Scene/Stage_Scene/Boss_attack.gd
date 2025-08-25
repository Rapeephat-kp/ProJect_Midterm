extends Node2D

@onready var sprite: Sprite2D = $Caution
@onready var hitbox: CollisionShape2D = $Attack_area/CollisionShape2D
@onready var effect: AnimatedSprite2D = $AnimatedSprite2D

@export var telegraph_time: float = 0.02
@export var fade_in_alpha: float = 0.2
@export var fade_step: float = 0.01

func _ready():
	hitbox.add_to_group("Mon_hit")
	sprite.texture = preload("res://Asset_Midterm/BG/1x1_#FFFFFFFF.png")
	sprite.scale = Vector2(50, 50)
	sprite.modulate.a = 0.0
	hitbox.disabled = true
	effect.visible = false

func show_warning(telegraph_time: float):
	# Fade in: 0 -> fade_in_alpha
	var alpha = 0.0
	while alpha < fade_in_alpha:
		alpha += fade_step
		if alpha > fade_in_alpha:
			alpha = fade_in_alpha
		sprite.modulate.a = alpha
		await get_tree().create_timer(0.02).timeout

	# รอ telegraph_time ให้ผู้เล่นเห็นตำแหน่ง
	await get_tree().create_timer(telegraph_time).timeout

	# Fade out: fade_in_alpha -> 0
	while alpha > 0.0:
		alpha -= fade_step
		if alpha < 0.0:
			alpha = 0.0
		sprite.modulate.a = alpha
		await get_tree().create_timer(0.02).timeout

	# เปิด hitbox + แสดง effect
	sprite.modulate.a = 0
	hitbox.disabled = false
	effect.visible = true
	effect.play("attack_1")  # ตรวจสอบชื่อ animation

	# รอ 0.5 วิ ให้ hitbox + effect ทำงาน
	await get_tree().create_timer(0.5).timeout
	hitbox.disabled = true
	effect.stop()
	effect.visible = false
	queue_free()
