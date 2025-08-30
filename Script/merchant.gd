extends CharacterBody2D


@onready var merchant_flip_l: AnimatedSprite2D = $Merchant/MerchantFlipL
@onready var merchant_flip_r: AnimatedSprite2D = $Merchant/MerchantFlipR

@onready var buttton_guide: Sprite2D = $"../buttton guide"

var gravity : float = 30
var talkable = false

func _ready() -> void:
	#explorer_flip_l.play("idle")
	merchant_flip_l.play("idle")
	buttton_guide.visible = false
	
func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity
	#talking()
	
				
				
func _on_detect_zone_l_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		merchant_flip_l.play("greeting")
		
		merchant_flip_l.visible = true
		merchant_flip_r.visible = false
		

func _on_detect_zone_l_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		#explorer_flip_l.play("idle")
		merchant_flip_l.play("idle")

func _on_detect_zone_r_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		merchant_flip_r.play("greeting")
	
		merchant_flip_r.visible = true
		merchant_flip_l.visible = false
		
func _on_detect_zone_r_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		merchant_flip_r.play("idle")

func _on_interact_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		buttton_guide.visible = true
		talkable = true

func _on_interact_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		buttton_guide.visible = false
		talkable = false
		CutSceneManager.stopAni()

func _input(event: InputEvent) -> void:
	var Character = Gamemanager.get_p()
	var cutscene = Gamemanager.get_currentScene()
	if event.is_action_pressed("talk") && talkable == true:
		print(talkable)
		if cutscene == "Stage 3":
			if Character == 1:
				CutSceneManager.playAni("Stage 3 Elendros with merchant")
			elif Character == 2:
				CutSceneManager.playAni("Stage 3 Nymera with merchant")
		if cutscene == "Stage 4":
			if Character == 1:
				CutSceneManager.playAni("Stage 4 Elendros with merchant")
			elif Character == 2:
				CutSceneManager.playAni("Stage 4 Nymera with merchant")
		if cutscene == "Stage 5":
			if Character == 1:
				CutSceneManager.playAni("Stage 5 Elendros with merchant")
			elif Character == 2:
				CutSceneManager.playAni("Stage 5 Nymera with merchant")
