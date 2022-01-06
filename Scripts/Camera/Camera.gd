extends Camera2D

onready var screen_shaker: Node = $ScreeShaker

func _on_Player_dash():
	screen_shaker.shake()
