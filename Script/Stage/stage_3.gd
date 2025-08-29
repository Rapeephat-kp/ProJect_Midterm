extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_water_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		$Nymera.position = $"spawn point".position





func _on_left_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		#$"map bounds/left/Label".visible = true
		$CanvasLayer/Control/Label.visible = true


func _on_left_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		#$"map bounds/left/Label".visible = false
		$CanvasLayer/Control/Label.visible = false

func _on_right_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
