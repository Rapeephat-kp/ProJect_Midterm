extends TextureProgressBar

func _process(delta: float) -> void:
		update_health_bar()

func update_health_bar():
	value = Gamemanager.get_Boss_health()
