extends GroundState

export var animation_speed: float = 1

# Walk State
func enter(_msg: = {}) -> void:
	.enter(_msg)

	player.handle_animation(self.name, animation_speed)

func physics_update(_delta: float) -> void:
	.physics_update(_delta)
	
	if not is_exiting_state:
		player.move()
	
	if player.movement == 0 and not is_exiting_state:
		state_machine.transition_to("Idle")
