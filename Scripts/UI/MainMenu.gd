extends Control

onready var start_button: Button = $Start

func _ready():
	AudioManager.play_menu_song()
	start_button.grab_focus()

func _on_Start_pressed():
	AudioManager.stop_menu_song()
	var _new_scene = get_tree().change_scene_to(Levels.cutscenes["Intro"])

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_Credits_pressed():
	var _credits_scene = get_tree().change_scene_to(Levels.ui["Credits"])
