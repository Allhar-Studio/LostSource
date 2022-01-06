extends CanvasLayer

onready var energy_bar: ProgressBar = $EnergyBar
onready var overload_bar: ProgressBar = $OverloadBar
onready var color_timer: Timer = $ColorTimer
onready var player: Player = get_parent().get_node("Player")

export var initial_color: Color

var style_box: StyleBox

func _ready() -> void:
	style_box = energy_bar.get("custom_styles/fg")
	style_box.bg_color = initial_color

func _physics_process(_delta) -> void:
	energy_bar.value = player.energy

	overload_bar.value = player.overload_timer.time_left * 10 if player.is_overloaded else 100.0

func _on_Player_use_energy() -> void:
	style_box.bg_color = Color.red
	color_timer.start()

func _on_ColorTimer_timeout() -> void:
	style_box.bg_color = initial_color
