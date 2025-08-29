extends TextureProgressBar

var Main_player
@onready var elendros: Elendros = $"../../../Main Character/Elendros"
@onready var nymera: Nymera = $"../../../Main Character/Nymera"

func _ready() -> void:
	var current_player = Gamemanager
	var p_value = current_player.get_p()
	if p_value == 1:
		#Main_player = get_node("../../../Elendros")
		Main_player = get_node("../../../Main Character/Elendros")
		Main_player.visible = true
		nymera.queue_free()
	elif p_value == 2:
		#Main_player = get_node("../../../Nymera")
		Main_player = get_node("../../../Main Character/Nymera")
		Main_player.visible = true
		elendros.queue_free()
func _process(delta: float) -> void:
	if Main_player:
		update_health_bar()

func update_health_bar():
	value = Gamemanager.get_player_health()
#hello
