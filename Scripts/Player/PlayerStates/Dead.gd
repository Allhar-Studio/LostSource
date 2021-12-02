extends PlayerState

export var animation_speed: float = 1

#Dead State
func enter(_msg: = {}):
	var animation = "NoEnergy" if player.energy <= 0 else self.name
	player.handle_animation(animation, animation_speed)
	player.set_velocity_x(0)
	player.energy = 0
	player.die_sound.play()

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass
