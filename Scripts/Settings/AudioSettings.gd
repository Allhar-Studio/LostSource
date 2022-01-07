extends Control

onready var master_label: Label = $VBoxContainer/MasterLabel
onready var master_slider: Slider = $VBoxContainer/MasterSlider
onready var music_label: Label = $VBoxContainer2/MusicLabel
onready var music_slider: Slider = $VBoxContainer2/MusicSlider
onready var sfx_label: Label = $VBoxContainer3/SfxLabel
onready var sfx_slider: Slider = $VBoxContainer3/SfxSlider

func _ready() -> void:
	master_slider.grab_focus()
	master_slider.value = GlobalSettings.volume["master"]
	music_slider.value = GlobalSettings.volume["music"]
	sfx_slider.value = GlobalSettings.volume["sfx"]

func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, linear2db(value))
	master_label.text = "Master Volume   %3d" % (value * 100) + "%"
	GlobalSettings.volume["master"] = value

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(1, linear2db(value))
	music_label.text = "Music Volume     %3d" % (value * 100) + "%"
	GlobalSettings.volume["music"] = value

func _on_SfxSlider_value_changed(value):
	AudioServer.set_bus_volume_db(2, linear2db(value))
	sfx_label.text = "Sfx Volume         %3d" % (value * 100) + "%"
	GlobalSettings.volume["sfx"] = value

func _on_AudioTab_visibility_changed():
	if self.visible == true:
		master_slider.grab_focus()
		master_slider.value = GlobalSettings.volume["master"]
		music_slider.value = GlobalSettings.volume["music"]
		sfx_slider.value = GlobalSettings.volume["sfx"]
