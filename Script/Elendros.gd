extends CharacterBody2D

class_name Elendros

@export var player_health = 100
@export var current_health : int = player_health
const SPEED = 150.0
const JUMP_VELOCITY = -325.0
@onready var Idel_E = $Idel_Sprite
@onready var Action_Sprite = $Action_Sprite
var is_attacking = false
var is_hurt = false

var is_poisoned: bool = false
var in_fog: bool = false   
var poison_timer: float = 0.0
@export var poison_duration: float = 3.0   
@export var poison_interval: float = 1.0   
@export var poison_damage: int = 1
var _poison_tick: float = 0.0

@onready var dust_trail: GPUParticles2D = $"Dust Trail"

func _process(delta: float) -> void:
	if is_on_floor() and abs(velocity.x) > 20:
		dust_trail.emitting = true
	else:
		dust_trail.emitting = false
	if !Gamemanager.get_player_buff():
		if in_fog:
			is_poisoned = true
			Gamemanager.set_player_debuff(true)
			poison_timer = poison_duration
			
		if is_poisoned:
			poison_timer -= delta
			_poison_tick -= delta
			
			if _poison_tick <= 0.0:
				Gamemanager.set_player_health(-poison_damage)
				_poison_tick = poison_interval
			
			if poison_timer <= 0.0:
				Gamemanager.set_player_debuff(false)
				is_poisoned = false
				print("Poison ended")
		else:
			in_fog = false
	if Gamemanager.get_player_health() <= 0:
		SceneTransition.change_scene("res://Scene/game_over.tscn")
#for_movement
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		AudioManager.set_and_play_sfx2_volume("res://SFX/InScene/jump.mp3",0)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction and is_attacking == false:
		Idel_E.visible = true
		Action_Sprite.visible = false
		Idel_E.flip_h = direction<0
		Action_Sprite.flip_h = direction>0
		velocity.x = direction * SPEED
		Idel_E.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		Idel_E.play("Idle")
	
	if Input.is_action_just_pressed("attack") and is_on_floor() and is_attacking == false:
		if Action_Sprite.flip_h == false:
			AudioManager.set_and_play_sfx2_volume("res://SFX/InScene/attack.mp3",0)
			$Attack_Zone_Elendros_right/CollisionShape2D.disabled = false
			#position.x -= 62 
		#print("attack")
			$Action2_Sprite.visible = true
			Idel_E.visible = false
			$Action2_Sprite.play("Attack")
			is_attacking = true
			await get_tree().create_timer(0.35).timeout
		#print("attack_done")
			$Action2_Sprite.visible = false
			$Attack_Zone_Elendros_right/CollisionShape2D.disabled = true
		else :
			AudioManager.set_and_play_sfx2_volume("res://SFX/InScene/attack.mp3",0)
			$Attack_Zone_Elendros/Attack_Zone_col.disabled = false
			Action_Sprite.visible = true
			Idel_E.visible = false
			Action_Sprite.play("Attack")
			is_attacking = true
			
			await get_tree().create_timer(0.35).timeout
		#print("attack_done")
			
		is_attacking = false
		Action_Sprite.visible = false
		Idel_E.visible = true
		$Attack_Zone_Elendros/Attack_Zone_col.disabled = true
	move_and_slide()
	
func get_attack_status():
	return is_attacking

func _on_elendros_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Mon_hit") and not is_hurt:
		is_hurt = true
		$AnimationPlayer.play("hurt")
		Gamemanager.achievement_1 = false
		var knockback_force = randf_range(700,1500) 
		if area.global_position.x < global_position.x:
			velocity.x = knockback_force
		else:
			velocity.x = -knockback_force
		velocity.y = -150

		await get_tree().create_timer(0.3).timeout
		velocity = Vector2.ZERO

		if Gamemanager.get_day_state():
			Gamemanager.set_player_health(-15)
		elif !Gamemanager.get_day_state():
			Gamemanager.set_player_health(-25)

		await get_tree().create_timer(0.3).timeout
		is_hurt = false
		
func set_in_fog(state: bool):
	in_fog = state
	if state:
		_poison_tick = 0.0   
		print("Player entered fog")
	else:
		print("Player left fog")

func get_infected():
	return is_poisoned
