extends Node2D


@onready var charName = $"CanvasLayer/stage cutscene/Setting_Panel_Bg/CharacterName"
@onready var phase = $"CanvasLayer/stage cutscene/Setting_Panel_Bg/Phase"
@onready var next_button: Button = $"CanvasLayer/stage cutscene/Setting_Panel_Bg/Next_Button"
@onready var autoplay_button: Button = $"CanvasLayer/stage cutscene/Setting_Panel_Bg/Autoplay_Button"
@onready var store_button: Button = $"CanvasLayer/stage cutscene/Setting_Panel_Bg/Store_Button"

var curScene = ""
#store
@onready var store: Node2D = $CanvasLayer/Store
@onready var inventory: Node2D = $CanvasLayer/Store/Inventory/Inventory

@onready var item_1: TextureRect = $"CanvasLayer/Store/Item 1"
@onready var item_2: TextureRect = $"CanvasLayer/Store/Item 2"
@onready var item1_name: Label = $CanvasLayer/Store/Details/Panel/Item1Name
@onready var info1_des: RichTextLabel = $CanvasLayer/Store/Details/Panel/Info_des
@onready var item2_name: Label = $CanvasLayer/Store/Details/Panel2/Item2Name
@onready var info2_des: RichTextLabel = $CanvasLayer/Store/Details/Panel2/Info_des
@onready var item_1_price: Label = $"CanvasLayer/Store/Buy Button/Item1_Buy/Item1_Price"
@onready var item_2_price: Label = $"CanvasLayer/Store/Buy Button/Item2_Buy/Item2_Price"
@onready var buy_fail_label_1: Label = $CanvasLayer/Store/Details/Panel/BuyFailLabel1
@onready var buy_fail_label_2: Label = $CanvasLayer/Store/Details/Panel2/BuyFailLabel2




var buy_text = " Buy"
#item price
var healPotion = 100
var maxHpPotion = 350
var atkPotion = 250
var antidotePotion = 400




#@onready var store_1_stage_3: Node2D = $"CanvasLayer/Store/Store 1 Stage 3"
@onready var store_2_stage_4: Node2D = $"CanvasLayer/Store/Store 2 Stage 4"
@onready var store_3_stage_5: Node2D = $"CanvasLayer/Store/Store 3 Stage 5"



@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var timer: Timer = $Timer
var autoplay = false
#typing writer
var visible_character = 0
@onready var audio = $AudioStreamPlayer


func _ready() -> void:
	#$AnimationPlayer.play("Elendros Ending")
	#store_1.visible = false
	Gamemanager.set_scene_spawn("Stage_3")
	store.visible = false
	buy_fail_label_1.visible = false
	buy_fail_label_2.visible = false
	'''
	store_1_stage_3.visible = false
	store_2_stage_4.visible = false
	store_3_stage_5.visible = false
	'''
func _process(delta: float) -> void:
	if visible_character != phase.visible_characters:
		visible_character = phase.visible_characters
		AudioManager.set_and_play_sfx("res://SFX/keyboard-typing-one-short.mp3")
		#AudioManager.play_sfx()
		
	if autoplay == false:
		timer.start()
		autoplay_button.modulate = "aaaaaa"
	elif autoplay == true:
		autoplay_button.modulate = "626262"
		
		
		
		
func pause():
	animation_player.pause()
	if autoplay == true:
		pass
	elif autoplay == false:
		timer.start()

func end():
	animation_player.play("RESET")		
		
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next") && not animation_player.is_playing():
		animation_player.play()
		
func _on_next_button_pressed() -> void:
	if not animation_player.is_playing():
		animation_player.play()
	AudioManager.play_press_sfx()
func _on_auto_button_pressed() -> void:
	autoplay = not autoplay
	print(autoplay)
	AudioManager.play_press_sfx()

func _on_timer_timeout() -> void:
	print("timeout")
	animation_player.play()

func playAni(AnimationName : String):
	animation_player.play(AnimationName)
	animation_player.seek(0,true)

func stopAni():
	animation_player.play("RESET")
	autoplay_button.modulate = "aaaaaa"
	autoplay = false
func stage1(Character : int):
	pass
# Ending Scene


func _on_store_button_pressed() -> void:
		set_store()
		AudioManager.play_press_sfx()	
			


func set_store():
		curScene = Gamemanager.get_currentScene()
		store.visible = true
		buy_fail_label_1.visible = false
		buy_fail_label_2.visible = false
		'''
		store_1_stage_3.visible = false
		store_2_stage_4.visible = false
		store_3_stage_5.visible = false
		'''
		if curScene == "Stage 3":
			#Set Item Image
			item_1.texture = load("res://Asset_Midterm/Item/Pixel_potion_pack/hp_potion.png")
			item_2.texture = load("res://Asset_Midterm/Item/Pixel_potion_pack/defense_potion.png")
			#Set details
			item1_name.text = "Healing Potion"
			info1_des.text = "Increase HP (+50 HP for each)"
			item_1_price.text = str(healPotion)+buy_text
			item2_name.text = "Max HP Potion"
			info2_des.text = "Increase Maximum of HP (+50 HP for each)"
			item_2_price.text = str(maxHpPotion)+buy_text
			
		elif curScene == "Stage 4":
			#Set Item Image
			item_1.texture = load("res://Asset_Midterm/Item/Pixel_potion_pack/defense_potion.png")
			item_2.texture = load("res://Asset_Midterm/Item/Pixel_potion_pack/fire_potion.png")
			#Set details
			item1_name.text = "Max HP Potion"
			info1_des.text = "Increase Maximum of HP (+50 HP for each)"
			item_1_price.text = str(maxHpPotion)+buy_text
			item2_name.text = "ATK Potion"
			info2_des.text = "Increase Maximum of ATK (+15 atk for each)"
			item_2_price.text = str(atkPotion)+buy_text
		if curScene == "Stage 5":
			#Set Item Image
			item_1.texture = load("res://Asset_Midterm/Item/Pixel_potion_pack/hp_potion.png")
			item_2.texture = load("res://Asset_Midterm/Item/Pixel_potion_pack/antidote_potion.png")
			#Set details
			item1_name.text = "Healing Potion"
			info1_des.text = "Increase HP (+50 HP for each)"
			item_1_price.text = str(healPotion)+buy_text
			item2_name.text = "Antiodote Potion"
			info2_des.text = "Protect from poisson gas"
			item_2_price.text = str(antidotePotion)+buy_text
func _on_hp_buy_pressed() -> void:
	if Gamemanager.get_coin() >= 100:
		inventory.buy_item("Healing Potion", 1)
		Gamemanager.set_coin(-100)
		print("Buyyyy")
	AudioManager.play_press_sfx()

func _on_exit_pressed() -> void:
	store.visible = false
	AudioManager.play_press_sfx()

func _on_item_1_buy_pressed() -> void:
	if curScene == "Stage 3":
		if Gamemanager.get_coin() >= healPotion:
			inventory.buy_item("Healing Potion", 1)
			Gamemanager.set_coin(-1*healPotion)
		else:
			buyFail1()
	elif curScene == "Stage 4":
		if Gamemanager.get_coin() >= maxHpPotion:
			inventory.buy_item("Increase Max Hp Potion", 1)
			Gamemanager.set_coin(-1*maxHpPotion)
		else:
			buyFail1()
	elif curScene == "Stage 5":
		if Gamemanager.get_coin() >= healPotion:
			inventory.buy_item("Healing Potion", 1)
			Gamemanager.set_coin(-1*healPotion)
		else:
			buyFail1()
	AudioManager.play_press_sfx()	
func _on_item_2_buy_pressed() -> void:
	if curScene == "Stage 3":
		if Gamemanager.get_coin() >= maxHpPotion:
			inventory.buy_item("Increase Max Hp Potion", 1)
			Gamemanager.set_coin(-1*maxHpPotion)
		else:
			buyFail2()
	elif curScene == "Stage 4":
		if Gamemanager.get_coin() >= atkPotion:
			inventory.buy_item("Atk Potion", 1)
			Gamemanager.set_coin(-1*atkPotion)
		else:
			buyFail2()
	elif curScene == "Stage 5":
		if Gamemanager.get_coin() >= antidotePotion:
			inventory.buy_item("Antidote Potion", 1)
			Gamemanager.set_coin(-1*antidotePotion)
		else:
			buyFail2()
	AudioManager.play_press_sfx()	
func buyFail1():
	buy_fail_label_1.visible = true
	await get_tree().create_timer(5).timeout
	buy_fail_label_1.visible = false
	
func buyFail2():
	buy_fail_label_2.visible = true
	await get_tree().create_timer(5).timeout
	buy_fail_label_2.visible = false
	

func display_Ending(player):
	AudioManager.set_and_play_music("res://BG Music/Ending.ogg")
	if player == 1:
		animation_player.play("Elendros Ending")

	if player == 2:
		animation_player.play("Nymera Ending")
		
func toWinScene():
	stopAni()
	SceneTransition.change_scene("res://Scene/win_scene.tscn")


func _on_skip_button_pressed() -> void:
	AudioManager.play_press_sfx()
	toWinScene()
	
func game_end():
	SceneTransition.change_scene("res://Scene/cut_scene.tscn")
	display_Ending(Gamemanager.get_p())
	
