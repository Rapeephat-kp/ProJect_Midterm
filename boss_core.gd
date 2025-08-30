extends Node2D
var health = 50
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0 :
		queue_free()


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player_hit"):
		health -= Gamemanager.get_player_dmg()
