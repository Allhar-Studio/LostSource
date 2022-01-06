extends Node

func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("ui_restart"):
		var _reload_scene = get_tree().reload_current_scene()
