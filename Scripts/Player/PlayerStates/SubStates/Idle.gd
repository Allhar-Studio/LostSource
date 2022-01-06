extends GroundState

export var animation_speed: float = 1

# Idle State
func enter(_msg: = {}) -> void:
	.enter(_msg)
	
	player.set_velocity_x(0)
	player.handle_animation(self.name, animation_speed)

func physics_update(_delta: float) -> void:
	.physics_update(_delta)

	if player.movement != 0 and player.can_move:
		state_machine.transition_to("Walk")

