extends CharacterBody2D

class_name Nymera

const SPEED = 150.0
const JUMP_VELOCITY = -325.0

@onready var Idle_Sprite = $Idle_Sprite
@onready var Action_Sprite = $Action_Sprite
@onready var Jump_Sprite = $Jump_Sprite
@onready var Jump2_Sprite = $Jump2_Sprite

var is_attacking = false
var is_jumping = false
var jump_timer = 0.0

@export var player_health = 100
@export var current_health : int = player_health

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# อัปเดต jump timer
	if is_jumping:
		jump_timer -= delta
		if jump_timer <= 0:
			is_jumping = false

	movement()
	move_and_slide()


func movement():
	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
		jump_timer = 0.45 
		
		if $Idle_Sprite.flip_h:
			Idle_Sprite.visible = false
			Action_Sprite.visible = false
			Jump_Sprite.visible = false
			Jump2_Sprite.visible = true
			Jump2_Sprite.play("Jump")
		else:
			Idle_Sprite.visible = false
			Action_Sprite.visible = false
			Jump2_Sprite.visible = false
			Jump_Sprite.visible = true
			Jump_Sprite.play("Jump")
			
	var direction := Input.get_axis("left", "right")
	if direction != 0 and not is_attacking:
		velocity.x = direction * SPEED
		Idle_Sprite.flip_h = direction < 0
		Action_Sprite.flip_h = direction > 0
		
		if is_on_floor() and not is_jumping:
			Idle_Sprite.visible = false
			Jump_Sprite.visible = false
			Action_Sprite.visible = true
			Jump2_Sprite.visible = false
			Action_Sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() and not is_attacking:
			Idle_Sprite.visible = true
			Action_Sprite.visible = false
			Jump_Sprite.visible = false
			Jump2_Sprite.visible = false
			Idle_Sprite.play("Idle_2")
			
	if is_on_floor():
		is_jumping = false
					
						
	# Attack 
	if Input.is_action_just_pressed("attack") and is_on_floor() and not is_attacking && $Idle_Sprite.flip_h == true:
		is_attacking = true

		Idle_Sprite.visible = false
		Jump_Sprite.visible = false
		Action_Sprite.visible = true
		Jump2_Sprite.visible = false
		Action_Sprite.play("Attack 1")
		$attack_zone_right/CollisionShape2D.disabled = false
		await get_tree().create_timer(0.35).timeout
		$attack_zone_right/CollisionShape2D.disabled = true
		is_attacking = false
		Idle_Sprite.visible = true
		Action_Sprite.visible = false
		Jump_Sprite.visible = false
		Jump2_Sprite.visible = false
		Idle_Sprite.play("Idle_2")
	
	if Input.is_action_just_pressed("attack") and is_on_floor() and not is_attacking && $Idle_Sprite.flip_h == false:
		is_attacking = true

		Idle_Sprite.visible = false
		Jump_Sprite.visible = false
		Action_Sprite.visible = true
		Jump2_Sprite.visible = false
		Action_Sprite.play("Attack 1")
		$attack_zone_left/CollisionShape2D.disabled = false
		await get_tree().create_timer(0.35).timeout
		$attack_zone_left/CollisionShape2D.disabled = true
		is_attacking = false
		Idle_Sprite.visible = true
		Action_Sprite.visible = false
		Jump_Sprite.visible = false
		Jump2_Sprite.visible = false
		Idle_Sprite.play("Idle_2")

	move_and_slide()
	


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Mon_hit"):
		Gamemanager.set_player_health(Gamemanager.get_player_health() - 15)
		Idle_Sprite.visible = false
		Action_Sprite.visible = true
		Jump_Sprite.visible = false
		Jump2_Sprite.visible = false
		
		var knockback_force = randf_range(700,1500) 
		if area.global_position.x < global_position.x:
			velocity.x = knockback_force
		else:
			velocity.x = -knockback_force
		velocity.y = -150

		await get_tree().create_timer(0.3).timeout
		velocity = Vector2.ZERO
		
		print("ouch")
		$AnimationPlayer.play("Hurt")
		await get_tree().create_timer(0.6).timeout
		
