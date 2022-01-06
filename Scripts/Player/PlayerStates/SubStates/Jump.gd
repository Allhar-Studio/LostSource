extends AirState

export var animation_speed: float = 1
export var prejump_animation_speed: float = 1.5

export var JUMP_FORCE: float = -700

# Jump State
func enter(_msg: = {}) -> void:
	.enter(_msg)
	
	player.handle_animation("PreJump", prejump_animation_speed)
	player.emit_jump_particle()
	player.is_jumping = true
	player.jumps_left -= 1
	player.velocity.y = JUMP_FORCE
	player.jump_sound.play()

func physics_update(_delta: float) -> void:
	.physics_update(_delta)
	
	if not is_exiting_state:
		player.move()
	
	if not player.jump_input and player.velocity.y < 0:
		player.velocity.y *= 0.8
		player.is_jump_timer_runing = false
		state_machine.transition_to("Fall", {"last_state": self.name})
	
	if player.velocity.y > 0:
		state_machine.transition_to("Fall", {"last_state": self.name})

func _on_AnimatedSprite_animation_finished() -> void:
	if player.anim_player.animation == "PreJump":
		player.handle_animation(self.name, animation_speed)
