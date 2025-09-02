extends CharacterBody2D
class_name Nymera

const SPEED = 150
const JUMP_VELOCITY = -325.0

@onready var dust_trail: GPUParticles2D = $"Dust Trail"

@onready var Idle_Sprite = $Idle_Sprite
@onready var Action_Sprite = $Action_Sprite
@onready var Jump_Sprite = $Jump_Sprite
@onready var Jump2_Sprite = $Jump2_Sprite

var is_attacking = false
var is_jumping = false
var is_flipped = false

@export var player_health = 100
@export var current_health : int = player_health

var is_poisoned: bool = false
var in_fog: bool = false   
var poison_timer: float = 0.0
@export var poison_duration: float = 3.0   
@export var poison_interval: float = 1.0   
@export var poison_damage: int = 2
var _poison_tick: float = 0.0

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
		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	movement()

func movement():
	var direction := Input.get_axis("left", "right")

	if direction != 0 and not is_attacking:
		velocity.x = direction * SPEED
		Action_Sprite.flip_h = direction > 0
		Idle_Sprite.flip_h = direction < 0

		if is_on_floor() and not is_jumping:
			Idle_Sprite.visible = false
			Jump_Sprite.visible = false
			Action_Sprite.visible = true
			Jump2_Sprite.visible = false
			Action_Sprite.play("run")
			#AudioManager.set_walk_status(true)
			#AudioManager.set_walk_sfx(Gamemanager.get_currentScene())
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if not is_attacking and is_on_floor() and not is_jumping:
			Idle_Sprite.visible = true
			Action_Sprite.visible = false
			Jump_Sprite.visible = false
			Jump2_Sprite.visible = false
			Idle_Sprite.play("Idle_2")
			#AudioManager.set_walk_status(false)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if $Idle_Sprite.flip_h == true:
			velocity.y = JUMP_VELOCITY
			Idle_Sprite.visible = false
			Action_Sprite.visible = false
			Jump_Sprite.visible = false
			Jump2_Sprite.visible = true
			Jump2_Sprite.play("Jump")
			AudioManager.set_and_play_sfx2_volume("res://SFX/InScene/jump.mp3",0)
		else:
			velocity.y = JUMP_VELOCITY
			Idle_Sprite.visible = false
			Action_Sprite.visible = false
			Jump2_Sprite.visible = false
			Jump_Sprite.visible = true
			Jump_Sprite.play("Jump")
			AudioManager.set_and_play_sfx2_volume("res://SFX/InScene/jump.mp3",0)

		is_jumping = true
		await get_tree().create_timer(0.45).timeout
		is_jumping = false

	if Input.is_action_just_pressed("attack") and is_on_floor() and not is_attacking and $Idle_Sprite.flip_h == true:
		is_attacking = true
		Idle_Sprite.visible = false
		Jump_Sprite.visible = false
		Action_Sprite.visible = true
		Jump2_Sprite.visible = false
		Action_Sprite.play("Attack 1")
		AudioManager.set_and_play_sfx2_volume("res://SFX/InScene/attack.mp3",0)
		$attack_zone_right/CollisionShape2D.disabled = false
		await get_tree().create_timer(0.35).timeout
		$attack_zone_right/CollisionShape2D.disabled = true
		is_attacking = false
		Idle_Sprite.visible = true
		Action_Sprite.visible = false
		Jump_Sprite.visible = false
		Jump2_Sprite.visible = false
		Idle_Sprite.play("Idle_2")

	if Input.is_action_just_pressed("attack") and is_on_floor() and not is_attacking and $Idle_Sprite.flip_h == false:
		is_attacking = true
		Idle_Sprite.visible = false
		Jump_Sprite.visible = false
		Action_Sprite.visible = true
		Jump2_Sprite.visible = false
		Action_Sprite.play("Attack 1")
		AudioManager.set_and_play_sfx2_volume("res://SFX/InScene/attack.mp3",0)
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
		if Gamemanager.get_day_state():
			Gamemanager.set_player_health(-15)
		elif !Gamemanager.get_day_state():
			Gamemanager.set_player_health(-25)
		Idle_Sprite.visible = false
		Action_Sprite.visible = true
		Jump_Sprite.visible = false
		Jump2_Sprite.visible = false
		Gamemanager.achievement_1 = false
		var knockback_force = randf_range(700, 1500)
		if area.global_position.x < global_position.x:
			velocity.x = knockback_force
		else:
			velocity.x = -knockback_force

		velocity.y = -150
		await get_tree().create_timer(0.3).timeout
		velocity = Vector2.ZERO

		#print("ouch")
		$AnimationPlayer.play("Hurt")
		await get_tree().create_timer(0.6).timeout

func set_in_fog(state: bool):
	in_fog = state
	if state:
		_poison_tick = 0.0   
		print("Player entered fog")
	else:
		print("Player left fog")

#func display_run_sfx():
	#if Gamemanager.get_currentScene() == "Stage 5" || Gamemanager.get_currentScene() == "Stage 6":
		#AudioManager.set_walk_sfx("res://SFX/InScene/running-in cave.ogg",20)
		#AudioManager.play_walk_sfx()
	#else:
		#AudioManager.set_walk_sfx("res://SFX/InScene/running-on-gravel.ogg",20)
