extends CharacterBody2D
@export var health = 50
@export var speed = 40
@export var gravity : float = 30
@export var sprite = "Idle"
var time_run = 0
var status = 1
var player_in_l = false
var player_in_r = false
var is_attack = false #เช็คว่าเข้าถึงเขตที่ตีได้รึยัง
var is_attacking = false #เช็คว่าตีอยู่มั้ย
var get_hit = false
var count = 0
var is_alive = true
@export var attack_delay = 0.8


func _ready() -> void:
	$AnimatedSprite2D.play(sprite)
	#velocity.x = speed if randf_range(0,1)< 0.5 else -speed
	#print(velocity.x)
	
func _process(delta: float) -> void:
	if get_hit == true:
		print(get_hit)
	#print(is_attacking)
	count -= delta
	if get_hit == true :
		velocity.x = 0
		move_and_slide()
	elif get_hit != true:
		movement()
		
	time_run += delta
	if(count >= 0):
		$AnimatedSprite2D.modulate = Color("#fad486")
	else:
		$AnimatedSprite2D.modulate = Color("White")
		
	if(health <= 0 ):
		set_process(false)
		_cancel_attack()
		dis()
	
func dis():
	is_alive = false 
	set_process(false)
	velocity.x = 0
	move_and_slide()
	_cancel_attack()
	$AnimatedSprite2D.play("Died")
	await get_tree().create_timer(0.8).timeout
	$AnimatedSprite2D.stop()
	$Body.disabled = true
	hide()
	await get_tree().create_timer(0.1).timeout
	queue_free()
	
func movement():
	if not is_alive:
		return  
	follow_player()
	if(is_attacking!= true):
		attack()
			
func follow_player():
	if not is_alive:
		return 
	var can_forward = $Check_Floor_l.is_colliding()
	var can_backward = $Check_Floor_r.is_colliding()
		
	if(is_attacking!= true):
		if(player_in_l == true && player_in_r != true && can_forward):
			$AnimatedSprite2D.play("Run")
			velocity.x = abs(speed)
			if(velocity.x > 0):
				$AnimatedSprite2D.flip_h = false
			
		elif(player_in_l != true && player_in_r == true && can_backward):
			$AnimatedSprite2D.play("Run")
			velocity.x = -(abs(speed))
			if(velocity.x < 0):
				$AnimatedSprite2D.flip_h = true
		elif(player_in_l != true && player_in_r != true || !can_backward && !can_forward):
			$AnimatedSprite2D.play("Idle")
			velocity.x = 0
			
		if not is_on_floor():
			velocity.y += gravity
	
		move_and_slide()
			
			
#Attack
func attack():
	if not is_alive:
		return 
		
	if player_in_l and is_attack:
		is_attacking = true
		$AnimatedSprite2D.play("attack")
		velocity.x = 0
		move_and_slide()
		await get_tree().create_timer(attack_delay).timeout

		if not is_alive || get_hit:  
			is_attacking = false
			return

		$attack_zone_left/CollisionShape2D.disabled = false
		await get_tree().create_timer(0.25).timeout

		if not is_alive|| get_hit: 
			$attack_zone_left/CollisionShape2D.disabled = true
			is_attacking = false
			return

		$attack_zone_left/CollisionShape2D.disabled = true
		is_attacking = false

	elif player_in_r and is_attack:
		is_attacking = true
		$AnimatedSprite2D.play("attack")
		velocity.x = 0
		move_and_slide()
		await get_tree().create_timer(attack_delay).timeout

		if not is_alive:
			is_attacking = false
			return

		$attack_zone_right/CollisionShape2D.disabled = false
		await get_tree().create_timer(0.25).timeout

		if not is_alive:
			$attack_zone_right/CollisionShape2D.disabled = true
			is_attacking = false
			return

		$attack_zone_right/CollisionShape2D.disabled = true
		is_attacking = false

		
func _cancel_attack():
	$attack_zone_right/CollisionShape2D.set_deferred("disabled", true)
	$attack_zone_left/CollisionShape2D.set_deferred("disabled", true)
	is_attacking = false
		
#Detect Player
func _on_detect_zone_l_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_l = true
		
func _on_detect_zone_l_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_l = false
		
func _on_detect_zone_r_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_r = true
		
func _on_detect_zone_r_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		player_in_r = false
		
func _on_area_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		is_attack = true
		
func _on_area_attack_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		is_attack = false
		
func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_hit") && get_hit != true && count <= 0:
		health -= 15
		get_hit = true
		if is_attacking:
			_cancel_attack() # ปิด hitbox ทันที
		$AnimatedSprite2D.play("Hurt")
		await get_tree().create_timer(1).timeout
		get_hit = false
		count = 1.5
