extends Control

onready var settings_header = $SettingsHeader

onready var tabs := [
	$GeneralTab,
	$AudioTab,
	$VideoTab,
	$InputsTab
]

func _ready() -> void:
	var _header_connect = settings_header.connect("change_tab", self, "_change_tab")
	
func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_back"):
		var _menu_scene = get_tree().change_scene_to(Levels.ui["Main"])

func _change_tab(index: int) -> void:
	for i in range(0, tabs.size()):
		if i == index:
			tabs[i].visible = true
		else:
			tabs[i].visible = false
