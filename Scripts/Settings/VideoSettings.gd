extends Control

onready var fullscreen_toggle: CheckButton = $FullScreen/FullScreenButton
onready var vsync_toggle: CheckButton = $Vsync/VsyncButton
onready var brightness_slider: Slider = $Brightness/BrightnessSlider

func _ready() -> void:
	_initial_config()

func _initial_config() -> void:
	fullscreen_toggle.grab_focus()
	fullscreen_toggle.pressed = GlobalSettings.video["fullscreen"]
	vsync_toggle.pressed = GlobalSettings.video["vsync"]
	brightness_slider.value = GlobalSettings.video["brightness"]

func _on_VideoTab_visibility_changed() -> void:
	if visible == true:
		_initial_config()

func _on_FullScreenButton_toggled(button_pressed) -> void:
	OS.window_fullscreen = button_pressed
	GlobalSettings.video["fullscreen"] = button_pressed

func _on_VsyncButton_toggled(button_pressed) -> void:
	OS.vsync_enabled = button_pressed
	GlobalSettings.video["vsync"] = button_pressed

func _on_BrightnessSlider_value_changed(value) -> void:
	GlobalSettings.update_brightness(value)
