extends Control

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_back"):
		var _menu_scene = get_tree().change_scene_to(Levels.ui["Main"])
