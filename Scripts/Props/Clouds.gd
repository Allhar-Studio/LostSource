extends ParallaxLayer

export var speed := 0.5
export var moving_speed := 5

onready var player = get_parent().get_parent().get_node("Player")

func _physics_process(_delta):
#	motion_scale.x = 0 if player.velocity.x <= 0 else 1
	motion_offset.x -= speed
