extends Sprite

onready var player = get_parent().get_node("Player")

func _ready() -> void:
	var player_anim: AnimatedSprite = player.get_node("AnimatedSprite")
	texture = player_anim.frames.get_frame(player_anim.animation, player_anim.frame)
