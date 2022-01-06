extends Control

onready var resume_button: Button = $ResumeButton
	
func _physics_process(_delta) -> void:
	if Input.is_action_just_pressed("ui_pause") and get_tree().get_current_scene().get_name() != "Intro":
		GameManager.set_is_paused(not GameManager.is_paused)
	
	if GameManager.is_paused and not visible:
		visible = true
		resume_button.grab_focus()
	elif not GameManager.is_paused:
		visible = false

func _is_valid_scene() -> bool:
	return get_tree().get_current_scene().get_name() != "Intro" and get_tree().get_current_scene().get_name() != "Credits"

func _on_ResumeButton_pressed() -> void:
	GameManager.set_is_paused(false)

func _on_MainMenu_pressed():
	AudioManager.stop_main_song()
	var _menu_scene = get_tree().change_scene_to(Levels.ui["Main"])
	
func _on_QuitButton_pressed() -> void:
	get_tree().quit()
