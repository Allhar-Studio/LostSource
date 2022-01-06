extends GroundState

export var animation_speed: float = 1

#Land State
func enter(_msg: = {}) -> void:
	.enter(_msg)
	player.handle_animation(self.name, animation_speed)
	player.hit_the_floor()
	player.land_sound.play()
	player.emit_jump_particle()

func physics_update(_delta: float) -> void:
	.physics_update(_delta)
	
	if not is_exiting_state:
		player.move()

func _on_AnimatedSprite_animation_finished() -> void:
	if player.anim_player.animation == self.name:
		if player.movement == 0 or not player.can_move:
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Walk")
