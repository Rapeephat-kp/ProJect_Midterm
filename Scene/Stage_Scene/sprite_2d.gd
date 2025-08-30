extends Sprite2D
var status = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.visible = false

func _process(delta: float) -> void:
	if status: 
		if Input.is_action_just_pressed("Interact") && $Sprite2D.visible == false:
			$"../../CanvasUI".visible = false
			$"../../Puzzle".visible = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") && $Sprite2D.visible == false:
		$Button.visible = true
		status = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Player"):
		$Button.visible = false
		status = false
		
