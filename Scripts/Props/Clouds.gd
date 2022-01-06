extends ParallaxLayer

export var speed := 0.5
export var moving_speed := 5

func _physics_process(_delta) -> void:
	motion_offset.x -= speed
