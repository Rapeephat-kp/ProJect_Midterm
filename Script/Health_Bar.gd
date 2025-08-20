extends TextureProgressBar

var Main_player

func _ready() -> void:
	var current_player = Gamemanager
	var p_value = current_player.get_p()
	if p_value == 1:
		Main_player = get_node("../../../Elendros")
		Main_player.visible = true
		$"../../../Nymera".queue_free()
	elif p_value == 2:
		Main_player = get_node("../../../Nymera")
		Main_player.visible = true
		$"../../../Elendros".queue_free()
func _process(delta: float) -> void:
	if Main_player:
		update_health_bar()

func update_health_bar():
	value = Gamemanager.get_player_health()
