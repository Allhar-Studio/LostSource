extends Control

onready var settings_header = $SettingsHeader

onready var tabs := [
	$GeneralTab,
	$AudioTab,
	$VideoTab,
	$InputsTab
]

signal go_back()

func _ready() -> void:
	var _header_connect = settings_header.connect("change_tab", self, "_change_tab")
	
func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_back"):
		if get_tree().get_current_scene().get_name() == "SettingsMenu":
			var _menu_scene = get_tree().change_scene_to(Levels.ui["Main"])
		else:
			emit_signal("go_back")

func _change_tab(index: int) -> void:
	for i in range(0, tabs.size()):
		if i == index:
			tabs[i].visible = true
		else:
			tabs[i].visible = false
