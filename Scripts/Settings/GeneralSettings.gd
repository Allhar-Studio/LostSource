extends Control

onready var icon_texture_normal: Texture = preload("res://Sprites/DropDownUi/arrow.png")
onready var icon_texture_focus: Texture = preload("res://Sprites/DropDownUi/arrow-green.png")

onready var language_button: OptionButton = $Language/LanguageButton
onready var hint_button: CheckButton = $Hint/HintButton
onready var vibration_button: CheckButton = $Vibration/VibrationButton

func _ready() -> void:
	_initial_config()

func _process(_delta) -> void:
	if language_button.get_draw_mode() == 0 and not language_button.has_focus():
		language_button.set_deferred("custom_icons/arrow", icon_texture_normal)
	else:
		language_button.set_deferred("custom_icons/arrow", icon_texture_focus)

func _initial_config() -> void:
	language_button.grab_focus()
	language_button.selected = GlobalSettings.general["language"]
	hint_button.pressed = GlobalSettings.general["hint"]
	vibration_button.pressed = GlobalSettings.general["vibration"]

func _on_LanguageButton_item_selected(index):
	if index == 0:
		print("en_US")
	else:
		print("pt_BR")
	GlobalSettings.general["language"] = index

func _on_HintButton_toggled(button_pressed):
	GlobalSettings.disable_hint(button_pressed)

func _on_VibrationButton_toggled(button_pressed):
	GlobalSettings.general["vibration"] = button_pressed

func _on_GeneralTab_visibility_changed():
	if self.visible == true:
		_initial_config()
