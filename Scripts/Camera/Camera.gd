extends Camera2D

onready var screen_shaker: Node = $ScreeShaker
onready var player: Player = get_parent().get_node("Player")

func _ready():
	var conect_dash_signal = player.connect("dash", self, "_on_Player_dash")
	if conect_dash_signal != 0:
		print(conect_dash_signal)

func _on_Player_dash():
	screen_shaker.shake()
