extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.visible = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		$Button.visible = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		$Button.visible = false
