extends CanvasLayer


func change_scene(target : String):
	$AnimationPlayer.play("disslove 1 s")
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("disslove 1 s")

func disslove():
	$AnimationPlayer.play("disslove 1 s")
