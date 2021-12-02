extends PlayerState

export var animation_speed: float = 1

# Walk State
func enter(_msg: = {}):
	player.handle_animation(self.name, animation_speed)

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	player.move()
	
	if player.dead:
		state_machine.transition_to("Dead")
	else:
		if player.jump_timer.time_left > 0 and player.jumps_left > 0 and player.velocity.y <= 0:
			state_machine.transition_to("Jump")
		
		if player.movement == 0 or not player.can_move:
			state_machine.transition_to("Idle")
			
		if player.velocity.y > 0:
			state_machine.transition_to("Fall", {"last_state": self.name})
			
		if Input.is_action_just_pressed("ui_dash") and player.can_dash():
			state_machine.transition_to("Dash")

func exit() -> void:
	pass

