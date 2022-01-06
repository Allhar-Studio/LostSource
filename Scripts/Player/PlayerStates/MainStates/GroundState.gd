class_name GroundState
extends PlayerState

# Ground State
func enter(_msg: = {}) -> void:
	.enter(_msg)
	
func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	if player.dead:
		state_machine.transition_to("Dead")
	else:
		if player.is_jump_timer_runing and player.jumps_left > 0 and player.velocity.y <= 0:
			state_machine.transition_to("Jump")
		
		elif player.velocity.y > 0:
			state_machine.transition_to("Fall", {"last_state": self.name})
		
		if Input.is_action_just_pressed("ui_dash") and player.can_dash():
			state_machine.transition_to("Dash")

func exit() -> void:
	.exit()
	
