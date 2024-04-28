extends CanvasLayer

func change_scene(givenScene: Variant, typeOfSceneChange: String) -> void:
	
	$AnimationPlayer.play('dissolve')
	await $AnimationPlayer.animation_finished
	if typeOfSceneChange == "packed":
		get_tree().change_scene_to_packed(givenScene)
	elif typeOfSceneChange == "file":
		get_tree().change_scene_to_file(givenScene)
	$AnimationPlayer.play_backwards('dissolve')
