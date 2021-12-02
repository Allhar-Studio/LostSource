extends CanvasLayer

onready var energy_bar: ProgressBar = $EnergyBar
onready var color_timer: Timer = $ColorTimer
onready var player: Player = get_parent().get_node("Player")

export var initial_color: Color

var style_box: StyleBox

func _ready():
	var conect_use_energy_signal = player.connect("use_energy", self, "_on_Player_use_energy")
	if conect_use_energy_signal != 0:
		print(conect_use_energy_signal)
	
	style_box = energy_bar.get("custom_styles/fg")
	style_box.bg_color = initial_color

func _physics_process(_delta):
	energy_bar.value = player.energy

func _on_Player_use_energy():
	style_box.bg_color = Color.red
	color_timer.start()

func _on_ColorTimer_timeout():
	style_box.bg_color = initial_color
