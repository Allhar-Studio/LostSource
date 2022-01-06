extends Control

onready var start_button: Button = $VBoxContainer/Start

func _ready() -> void:
	GameManager.set_is_paused(false)
	AudioManager.play_menu_song()
	start_button.grab_focus()

func _on_Start_pressed() -> void:
	AudioManager.stop_menu_song()
	var _new_scene = get_tree().change_scene_to(Levels.cutscenes["Intro"])

func _on_Settings_pressed():
	var _settings_scene = get_tree().change_scene_to(Levels.ui["Settings"])

func _on_Credits_pressed() -> void:
	var _credits_scene = get_tree().change_scene_to(Levels.ui["Credits"])

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
