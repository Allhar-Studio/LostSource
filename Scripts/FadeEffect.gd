extends CanvasLayer

onready var player: Player = get_parent().get_node("Player")
onready var anim: AnimationPlayer = $AnimationPlayer

func _ready():
	var conect_dead_signal = player.connect("dead", self, "_on_Player_dead")
	if conect_dead_signal != 0:
		print(conect_dead_signal)

func _on_Player_dead():
	anim.play("fade_in")
	
func restart():
	GameManager.restart()
