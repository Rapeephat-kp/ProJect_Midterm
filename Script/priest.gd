extends CharacterBody2D
@export var health = 50
@export var speed = 40
@export var gravity : float = 30
@export var sprite = "Idle"
var time_run = 0
var status = 1
var player_in_l = false
var player_in_r = false
var is_attack = false
var is_attacking = false
var get_hit = false
var count = 0
var is_alive = true
var attack_canceled = false
@export var attack_delay = 0.3

func _ready() -> void:
	$AnimatedSprite2D.play(sprite)
	
func _process(delta: float) -> void:
	if get_hit:
		velocity.x = 0
		move_and_slide()
	else:
		movement()
	count -= delta
	time_run += delta
	if count >= 0:
		$AnimatedSprite2D.modulate = Color("#fad486")
	else:
		$AnimatedSprite2D.modulate = Color("White")
	if health <= 0:
		dis()
	
func dis():
	is_alive = false
	$AnimatedSprite2D.play("Died")
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D.stop()
	$CollisionShape2D.disabled = true
	hide()
	await get_tree().create_timer(0.1).timeout
	queue_free()
	
func movement():
	if not is_alive:
		return
	follow_player()
	if not is_attacking:
		attack()
			
func follow_player():
	if player_in_l != true && player_in_r != true:
		velocity.x = 0
		move_and_slide()
	if not is_alive:
		return
	if not is_attacking:
		if player_in_l and not player_in_r:
			$AnimatedSprite2D.play("walk")
			velocity.x = abs(speed)
			print(velocity.x)
			if velocity.x > 0:
				$AnimatedSprite2D.flip_h = false
		elif not player_in_l and player_in_r:
			$AnimatedSprite2D.play("walk")
			velocity.x = -(abs(speed))
			print(velocity.x)
			if velocity.x < 0:
				$AnimatedSprite2D.flip_h = true
		elif not player_in_l and not player_in_r:
			$AnimatedSprite2D.play("Idle")
			velocity.x = 0
		if not is_on_floor():
			velocity.y += gravity
		move_and_slide()
			
func attack():
	if not is_alive:
		return
	if player_in_l and is_attack and not get_hit:
		is_attacking = true
		$AnimatedSprite2D.play("attack")
		velocity.x = 0
		move_and_slide()
		await get_tree().create_timer(attack_delay).timeout
		if not is_alive or get_hit :
			_cancel_attack()
			return
		$attack_zone_left/CollisionShape2D.disabled = false
		$AnimatedSprite2D.play("Idle")
		await get_tree().create_timer(1).timeout
		$attack_zone_left/CollisionShape2D.disabled = true
		is_attacking = false
	elif player_in_r and is_attack and not get_hit:
		is_attacking = true
		$AnimatedSprite2D.play("attack")
		velocity.x = 0
		move_and_slide()
		await get_tree().create_timer(attack_delay).timeout
		if not is_alive or get_hit :
			_cancel_attack()
			return
		$attack_zone_right/CollisionShape2D.disabled = false
		$AnimatedSprite2D.play("Idle")
		await get_tree().create_timer(1).timeout
		$attack_zone_right/CollisionShape2D.disabled = true
		is_attacking = false
		
func _cancel_attack():
	$attack_zone_right/CollisionShape2D.set_deferred("disabled", true)
	$attack_zone_left/CollisionShape2D.set_deferred("disabled", true)
	is_attacking = false
		
func _on_detect_zone_l_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		print("LEFT in")
		player_in_l = true
		
func _on_detect_zone_l_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		print("LEFT out")
		player_in_l = false
		
func _on_detect_zone_r_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		print("RIGHT in")
		player_in_r = true
		
func _on_detect_zone_r_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		print("RIGHT out")
		player_in_r = false
		
func _on_area_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		is_attack = true
		
func _on_area_attack_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		is_attack = false
		
func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_hit") and not get_hit and count <= 0:
		health -= 15
		get_hit = true
		if is_attacking:
			_cancel_attack()
		$AnimatedSprite2D.play("Hurt")
		await get_tree().create_timer(0.5).timeout
		get_hit = false
		count = 1.5
