extends HBoxContainer

export var highlight_color: Color = Color.white
export var normal_color: Color = Color.white

var title_index := 0

onready var labels = [
	$General,
	$Audio,
	$Video,
	$Input
]

onready var left_button: Button = $ArrowLeft
onready var right_button: Button = $ArrowRight

signal change_tab(tab_index)

func _ready():
	labels[title_index].add_color_override("font_color", highlight_color)

func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_settings_left"):
		left_button.emit_signal("pressed")
	if Input.is_action_just_pressed("ui_settings_right"):
		right_button.emit_signal("pressed")

func handle_change_tab() -> void:
	emit_signal("change_tab", title_index)
	for i in range(0, labels.size()):
		if i == title_index:
			labels[i].add_color_override("font_color", highlight_color)
		else:
			labels[i].add_color_override("font_color", Color.white)
	
func handle_back() -> void:
	if title_index == 0:
		title_index = labels.size() - 1
	else:
		title_index -= 1
	handle_change_tab()

func handle_foward() -> void:
	if title_index == labels.size() - 1:
		title_index = 0
	else:
		title_index += 1
	handle_change_tab()

func _on_ArrowLeft_pressed():
	handle_back()

func _on_ArrowRight_pressed():
	handle_foward()

func _on_General_gui_input(event):
	if event.is_pressed() and event.button_index == 1:
		title_index = 0
		handle_change_tab()

func _on_Audio_gui_input(event):
	if event.is_pressed() and event.button_index == 1:
		title_index = 1
		handle_change_tab()

func _on_Video_gui_input(event):
	if event.is_pressed() and event.button_index == 1:
		title_index = 2
		handle_change_tab()

func _on_Input_gui_input(event):
	if event.is_pressed() and event.button_index == 1:
		title_index = 3
		handle_change_tab()

func _on_SettingsHeader_visibility_changed():
	if self.visible == true:
		title_index = 0
		handle_change_tab()
