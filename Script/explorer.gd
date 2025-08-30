extends CharacterBody2D

@onready var explorer_flip_l: AnimatedSprite2D = $ExplorerFlipL
@onready var explorer_flip_r: AnimatedSprite2D = $ExplorerFlipR


@onready var buttton_guide: Sprite2D = $"../buttton guide"

var gravity : float = 30
var talkable = false

func _ready() -> void:
	explorer_flip_l.play("idle")
	#merchant_flip_l.play("idle")
	buttton_guide.visible = false
	
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity
	#talking()
	
				
				
func _on_detect_zone_l_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		explorer_flip_l.play("greeting")
		explorer_flip_l.visible = true
		explorer_flip_r.visible = false
		
		#merchant_flip_l.visible = true
		#merchant_flip_r.visible = false
		

func _on_detect_zone_l_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		explorer_flip_l.play("idle")
		#merchant_flip_l.play("idle")

func _on_detect_zone_r_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		explorer_flip_r.play("greeting")
		explorer_flip_r.visible = true
		explorer_flip_l.visible = false
		
		#merchant_flip_r.visible = true
		#merchant_flip_l.visible = false
		
func _on_detect_zone_r_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		explorer_flip_r.play("idle")
		#merchant_flip_r.play("idle")

func _on_interact_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		buttton_guide.visible = true
		talkable = true

func _on_interact_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		buttton_guide.visible = false
		talkable = false
		CutSceneManager.stopAni()
'''
func talking():
	var Character = Gamemanager.get_p()
	var cutscene = Gamemanager.get_currentScene()
	if Input.is_action_just_pressed("talk") && talkable == true:
		print(talkable)
		if cutscene == "Stage 1-1":
			if Character == 1:
				CutSceneManager.stage1()
				#CutSceneManager.playAni("Stage 1 1-2 Elendros")
			elif Character == 2:
				CutSceneManager.playAni("Stage 1 1-2 Nymera")
'''

func _input(event: InputEvent) -> void:
	var Character = Gamemanager.get_p()
	var cutscene = Gamemanager.get_currentScene()
	if event.is_action_pressed("talk") && talkable == true:
		print(talkable)
		if cutscene == "Stage 1-1":
			if Character == 1:
				CutSceneManager.playAni("Stage 1 1-2 Elendros")
			elif Character == 2:
				CutSceneManager.playAni("Stage 1 1-2 Nymera")
		if cutscene == "Stage 1-2":
			if Character == 1:
				CutSceneManager.playAni("Stage 1 2-2 Elendros")
			elif Character == 2:
				CutSceneManager.playAni("Stage 1 2-2 Nymera")
		if cutscene == "Stage 2":
			if Character == 1:
				CutSceneManager.playAni("Stage 2 Elendros")
			elif Character == 2:
				CutSceneManager.playAni("Stage 2 Nymera")
		if cutscene == "Stage 3":
			if Character == 1:
				CutSceneManager.playAni("Stage 3 Elendros with explorer")
			elif Character == 2:
				CutSceneManager.playAni("Stage 3 Nymera with explorer")
		if cutscene == "Stage 4":
			if Character == 1:
				CutSceneManager.playAni("Stage 4 Elendros with explorer")
			elif Character == 2:
				CutSceneManager.playAni("Stage 4 Nymera with explorer")
		if cutscene == "Stage 5":
			if Character == 1:
				CutSceneManager.playAni("Stage 5 Elendros with explorer")
			elif Character == 2:
				CutSceneManager.playAni("Stage 5 Nymera with explorer")
		
