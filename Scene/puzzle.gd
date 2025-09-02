extends CanvasLayer
var input_sequence 
var correct_sequence 
var DisplayLabel 
var ConfirmButton
var Button1
var Button2
var Button3
var Button4
var Button5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_sequence = []
	correct_sequence = [5, 5, 3, 2, 4, 1, 2]
	DisplayLabel = $Control/Panel/Label
	DisplayLabel.modulate = "ffffff"
	ConfirmButton = $Control/Confirm
	Button1 = $Control/Button1
	Button2 = $Control/Button2
	Button3 = $Control/Button3
	Button4 = $Control/Button4
	Button5 = $Control/Button5
	
	Button1.connect("pressed", Callable(self, "_on_NumberButton_pressed").bind(1))
	Button2.connect("pressed", Callable(self, "_on_NumberButton_pressed").bind(2))
	Button3.connect("pressed", Callable(self, "_on_NumberButton_pressed").bind(3))
	Button4.connect("pressed", Callable(self, "_on_NumberButton_pressed").bind(4))
	Button5.connect("pressed", Callable(self, "_on_NumberButton_pressed").bind(5))
	ConfirmButton.connect("pressed", Callable(self, "_on_ConfirmButton_pressed"))


func _on_NumberButton_pressed(number):
	if input_sequence.size() >= correct_sequence.size():
		input_sequence.pop_front()
	var display_text = ""
	input_sequence.append(number)
	for x in input_sequence:
		display_text += " "
		display_text += str(x)
		DisplayLabel.text = display_text
	AudioManager.play_press_sfx()

func _on_ConfirmButton_pressed():
	if input_sequence == correct_sequence:
		DisplayLabel.modulate = "#007a28"
		AudioManager.set_and_play_sfx_volume("res://SFX/InScene/correct-answer.mp3",0)
		await get_tree().create_timer(0.25).timeout
		AudioManager.set_and_play_sfx_volume("res://SFX/InScene/small-rock-break-194553.mp3",0)
		$".".visible = false
		$"../CanvasUI".visible = true
		$"../Tile_Map/Sprite2D/Sprite2D".visible = true
		$"../Tile_Map/Hidden".enabled = false
	else:
		DisplayLabel.modulate = "7a0028"
		input_sequence.clear()
		AudioManager.set_and_play_sfx_volume("res://SFX/InScene/wrong-answer.ogg",0)
		await get_tree().create_timer(0.25).timeout
		DisplayLabel.modulate = "ffffff" 
		DisplayLabel.text = ""
		
	AudioManager.play_press_sfx()

func _on_exit_pressed() -> void:
	$".".visible = false
	$"../CanvasUI".visible = true
	AudioManager.play_press_sfx()
